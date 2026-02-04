document.addEventListener('DOMContentLoaded', function() {
    const track = document.querySelector('.carousel-slide');
    // Guard clause in case the carousel isn't on the current page
    if (!track) return;

    const slides = Array.from(track.children);
    const nextButton = document.querySelector('.next-btn');
    const prevButton = document.querySelector('.prev-btn');
    const dots = Array.from(document.querySelectorAll('.indicator'));
    
    if (slides.length === 0) return;

    let currentIndex = 0;

    function updateCarousel() {
        track.style.transform = 'translateX(-' + (currentIndex * 100) + '%)';
        dots.forEach(dot => dot.classList.remove('active'));
        if (dots[currentIndex]) {
            dots[currentIndex].classList.add('active');
        }
    }

    if (nextButton) {
        nextButton.addEventListener('click', () => {
            currentIndex = (currentIndex + 1) % slides.length;
            updateCarousel();
        });
    }

    if (prevButton) {
        prevButton.addEventListener('click', () => {
            currentIndex = (currentIndex - 1 + slides.length) % slides.length;
            updateCarousel();
        });
    }

    dots.forEach((dot, index) => {
        dot.addEventListener('click', () => {
            currentIndex = index;
            updateCarousel();
        });
    });
});
