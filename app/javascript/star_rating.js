// Star Rating functionality
(function() {
  function createStarRating(element, options) {
    const videoId = options.videoId;
    const initialRating = options.initialRating || 0;
    const maxStars = options.maxStars || 5;

    let currentRating = initialRating;
    let hoveredRating = 0;

    function init() {
      element.innerHTML = '';
      element.className = 'star-rating flex items-center space-x-1 cursor-pointer';

      for (let i = 1; i <= maxStars; i++) {
        const star = document.createElement('span');
        star.className = 'star text-xl transition-colors duration-200 text-gray-300';
        star.innerHTML = '★';
        star.setAttribute('data-rating', i);

        star.addEventListener('mouseenter', function() {
          hoveredRating = i;
          updateDisplay();
        });

        star.addEventListener('mouseleave', function() {
          hoveredRating = 0;
          updateDisplay();
        });

        star.addEventListener('click', function() {
          currentRating = i;
          updateDisplay();
          saveRating(i);
        });

        element.appendChild(star);
      }

      updateDisplay();
    }

    function updateDisplay() {
      const stars = element.querySelectorAll('.star');
      const displayRating = hoveredRating || currentRating;

      stars.forEach(function(star, index) {
        const starRating = index + 1;
        if (starRating <= displayRating) {
          star.className = 'star text-xl transition-colors duration-200 text-yellow-400';
        } else {
          star.className = 'star text-xl transition-colors duration-200 text-gray-300';
        }
      });
    }

    function saveRating(rating) {
      fetch('/vids/' + videoId + '/rate', {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ rating: rating })
      }).then(function(response) {
        if (response.ok) {
          return response.json();
        }
        throw new Error('Failed to save rating');
      }).then(function(data) {
        console.log('Video ' + videoId + ' rated: ' + data.rating + ' stars');
      }).catch(function(error) {
        console.error('Error saving rating:', error);
      });
    }

    init();
  }

  // Initialize star ratings when DOM is ready
  function initializeStarRatings() {
    document.querySelectorAll('.star-rating-container').forEach(function(container) {
      const videoId = container.getAttribute('data-video-id');
      const initialRating = parseInt(container.getAttribute('data-initial-rating')) || 0;

      createStarRating(container, {
        videoId: videoId,
        initialRating: initialRating,
        maxStars: 5
      });
    });
  }

  // Initialize on DOM ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initializeStarRatings);
  } else {
    initializeStarRatings();
  }

  // Also initialize on Turbo page loads
  document.addEventListener('turbo:load', initializeStarRatings);
})();