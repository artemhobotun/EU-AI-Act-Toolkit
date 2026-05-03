// EU AI Act Toolkit Pages Interactivity
// Handles quiz scoring, result recommendations, animations, and navigation state

(function() {
  'use strict';

  // Quiz functionality: Score readiness level and suggest resources
  function initQuiz() {
    const quizForm = document.querySelector('form[data-quiz]');
    if (!quizForm) return;

    quizForm.addEventListener('submit', function(e) {
      e.preventDefault();

      const answers = document.querySelectorAll('input[data-quiz-score]');
      if (answers.length === 0) return;

      let totalScore = 0;
      let maxScore = 0;

      answers.forEach(function(input) {
        if (input.checked || input.type === 'range') {
          const score = parseFloat(input.getAttribute('data-quiz-score')) || 0;
          totalScore += score;
        }
        const max = parseFloat(input.getAttribute('data-quiz-max')) || 0;
        maxScore = Math.max(maxScore, max);
      });

      const percentage = maxScore > 0 ? (totalScore / maxScore) * 100 : 0;
      displayQuizResults(percentage);
    });
  }

  // Display quiz results with recommendations based on readiness level
  function displayQuizResults(percentage) {
    let resultsHtml = '';
    let readinessLevel = '';
    let recommendedResources = [];

    if (percentage < 33) {
      readinessLevel = 'Low Readiness';
      recommendedResources = [
        { href: 'packs.html', text: 'Starter Pack', title: 'Begin your EU AI Act readiness journey' },
        { href: 'resources.html', text: 'FAQ', title: 'Common questions answered' },
        { href: 'official-sources.html', text: 'Official Sources', title: 'Authoritative EU AI Act resources' }
      ];
    } else if (percentage < 66) {
      readinessLevel = 'Moderate Readiness';
      recommendedResources = [
        { href: 'packs.html', text: 'Vendor Assessment Pack', title: 'Assess your vendor AI practices' },
        { href: 'use-cases.html', text: 'Use Cases', title: 'Learn from sector-specific examples' },
        { href: 'resources.html', text: 'Resource Library', title: 'Access templates and checklists' }
      ];
    } else {
      readinessLevel = 'High Readiness';
      recommendedResources = [
        { href: 'maintainer.html', text: 'Escalation Guide', title: 'Expert guidance for complex scenarios' },
        { href: 'use-cases.html', text: 'Advanced Use Cases', title: 'Deep-dive sector guidance' },
        { href: 'community.html', text: 'Community', title: 'Connect with other practitioners' }
      ];
    }

    resultsHtml = '<div class="quiz-results" role="region" aria-live="polite">';
    resultsHtml += '<h3>Your Readiness Score: ' + Math.round(percentage) + '%</h3>';
    resultsHtml += '<p><strong>' + readinessLevel + '</strong></p>';
    resultsHtml += '<p class="readiness-description">';

    if (percentage < 33) {
      resultsHtml += 'You\'re just getting started. Focus on understanding your current AI inventory and initial risk screening.';
    } else if (percentage < 66) {
      resultsHtml += 'You\'ve made good progress. Now assess your vendors and deepen your governance practices.';
    } else {
      resultsHtml += 'You\'re well-prepared. Consider sharing your practices and supporting others.';
    }

    resultsHtml += '</p><h4>Recommended Next Steps:</h4><ul>';

    recommendedResources.forEach(function(resource) {
      resultsHtml += '<li><a href="' + resource.href + '" title="' + resource.title + '">' + resource.text + '</a></li>';
    });

    resultsHtml += '</ul></div>';

    const resultsContainer = document.querySelector('[data-quiz-results]');
    if (resultsContainer) {
      resultsContainer.innerHTML = resultsHtml;
      resultsContainer.scrollIntoView({ behavior: 'smooth' });
    }
  }

  // Smooth reveal animations using IntersectionObserver
  function initScrollAnimations() {
    const elementsToAnimate = document.querySelectorAll('[data-animate], .card, .resource-card, .tile');

    if ('IntersectionObserver' in window) {
      const observer = new IntersectionObserver(function(entries) {
        entries.forEach(function(entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add('revealed');
            observer.unobserve(entry.target);
          }
        });
      }, { threshold: 0.1 });

      elementsToAnimate.forEach(function(el) {
        observer.observe(el);
      });
    } else {
      // Fallback: animate immediately on older browsers
      elementsToAnimate.forEach(function(el) {
        el.classList.add('revealed');
      });
    }
  }

  // Update active navigation state based on current page
  function updateActiveNavigation() {
    const currentFile = window.location.pathname.split('/').pop() || 'index.html';
    const navLinks = document.querySelectorAll('nav a[href], .nav-link[href]');

    navLinks.forEach(function(link) {
      const href = link.getAttribute('href');
      if (href && href.includes(currentFile)) {
        link.classList.add('active');
        link.setAttribute('aria-current', 'page');
      } else {
        link.classList.remove('active');
        link.removeAttribute('aria-current');
      }
    });
  }

  // Add copy-link functionality to important resource cards
  function initCopyLinks() {
    const copyButtons = document.querySelectorAll('[data-copy-link]');

    copyButtons.forEach(function(button) {
      button.addEventListener('click', function(e) {
        e.preventDefault();

        const card = button.closest('[data-resource-id], .card, .resource-card');
        if (!card) return;

        const resourceId = card.getAttribute('data-resource-id') || card.getAttribute('id');
        const resourceTitle = card.getAttribute('data-resource-title') || card.textContent.split('\n')[0];

        if (resourceId || resourceTitle) {
          const pageUrl = window.location.href;
          const linkText = resourceTitle || 'Resource';
          const copyText = linkText + ': ' + pageUrl;

          if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(copyText).then(function() {
              showNotification('Link copied to clipboard');
              button.textContent = '✓ Copied';
              setTimeout(function() {
                button.textContent = 'Copy Link';
              }, 2000);
            }).catch(function() {
              fallbackCopyToClipboard(copyText);
            });
          } else {
            fallbackCopyToClipboard(copyText);
          }
        }
      });
    });
  }

  // Fallback copy-to-clipboard for older browsers
  function fallbackCopyToClipboard(text) {
    const textarea = document.createElement('textarea');
    textarea.value = text;
    textarea.style.position = 'fixed';
    textarea.style.left = '-9999px';
    document.body.appendChild(textarea);
    textarea.select();

    try {
      document.execCommand('copy');
      showNotification('Link copied to clipboard');
    } catch (err) {
      console.warn('Copy failed:', err);
    }

    document.body.removeChild(textarea);
  }

  // Show temporary notification message
  function showNotification(message) {
    const notification = document.createElement('div');
    notification.className = 'notification';
    notification.textContent = message;
    notification.style.cssText = 'position: fixed; bottom: 20px; right: 20px; background: #333; color: #fff; padding: 12px 20px; border-radius: 4px; z-index: 9999; font-size: 14px;';

    document.body.appendChild(notification);

    setTimeout(function() {
      notification.style.opacity = '0';
      notification.style.transition = 'opacity 0.3s ease';
      setTimeout(function() {
        document.body.removeChild(notification);
      }, 300);
    }, 3000);
  }

  // Initialize all functionality when DOM is ready
  function init() {
    initQuiz();
    initScrollAnimations();
    updateActiveNavigation();
    initCopyLinks();
  }

  // Ensure DOM is ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
