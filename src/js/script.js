// =============================
// ESCAPE HTML UTILITY
// =============================
function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}



// =============================
// OPEN / CLOSE MODAL
// =============================
function openGameModal(gameId, title, cover, platforms, genres, rating) {
    document.getElementById('gameTitle').textContent = title;
    document.getElementById('gamePlatforms').textContent = platforms;
    document.getElementById('gameGenres').textContent = genres;
    document.getElementById('gameRating').textContent = rating;
    document.getElementById('reviewGameId').value = gameId;

    const coverImg = document.getElementById('gameCover');
    if (cover && cover.trim() !== '') {
        coverImg.src = cover;
        coverImg.style.display = 'block';
    } else {
        coverImg.style.display = 'none';
    }

    loadGameReviews(gameId);
    loadFavoriteStatus(gameId);

    document.getElementById('gameModal').style.display = 'block';
}

function closeGameModal() {
    document.getElementById('gameModal').style.display = 'none';
    document.getElementById('newReviewForm').reset();
}

// Close modal by clicking outside
window.addEventListener('click', function(event) {
    const modal = document.getElementById('gameModal');
    if (event.target === modal) closeGameModal();
});

// =============================
// LOAD GAME REVIEWS
// =============================
async function loadGameReviews(gameId) {
    const container = document.getElementById('reviewsContainer');
    container.innerHTML = '<div class="no-reviews">Cargando reseñas...</div>';

    try {
        const res = await fetch(`api/get_reviews.php?gameid=${gameId}`);
        const data = await res.json();

        if (data.success && data.reviews.length > 0) {
            container.innerHTML = data.reviews.map(review => `
                <div class="review-box">
                    <div class="review-header">
                        <span class="review-username">${escapeHtml(review.username)}</span>
                        <span class="review-rating">${'★'.repeat(review.rating)}</span>
                    </div>
                    <div class="review-content">${escapeHtml(review.content)}</div>
                </div>
            `).join('');
        } else {
            container.innerHTML = '<div class="no-reviews">No hay reseñas para este juego aún.</div>';
        }
    } catch (err) {
        console.error(err);
        container.innerHTML = '<div class="no-reviews">Error al cargar reseñas.</div>';
    }
}

// =============================
// FAVORITES
// =============================
function loadFavoriteStatus(gameId) {
    const btn = document.getElementById('favoriteBtn');
    if (!btn) return;

    btn.disabled = true;
    btn.textContent = 'Cargando...';

    fetch(`api/favorite_status.php?gameid=${gameId}`)
        .then(res => res.json())
        .then(data => {
            if (data.success) {
                btn.textContent = data.favorited ? 'Favorito ❤️' : 'Agregar a favoritos 🤍';
                btn.dataset.favorited = data.favorited ? 'true' : 'false';
                btn.dataset.gameid = gameId;
                btn.disabled = false;

                if (!btn.dataset.listenerAttached) {
                    btn.addEventListener('click', () => toggleFavorite(btn));
                    btn.dataset.listenerAttached = 'true';
                }
            } else {
                btn.textContent = 'Error';
                btn.disabled = true;
            }
        })
        .catch(() => {
            btn.textContent = 'Error';
            btn.disabled = true;
        });
}

function toggleFavorite(btn) {
    const gameId = btn.dataset.gameid;
    btn.disabled = true;
    btn.textContent = 'Guardando...';

    fetch('api/favorite.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `gameid=${encodeURIComponent(gameId)}`
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            btn.textContent = data.favorited ? 'Favorito ❤️' : 'Agregar a favoritos 🤍';
            btn.dataset.favorited = data.favorited ? 'true' : 'false';
        } else {
            alert('Error: ' + data.message);
        }
    })
    .catch(() => alert('Error al cambiar favorito'))
    .finally(() => btn.disabled = false);
}

// =============================
// REVIEW STARS & SUBMISSION
// =============================
document.addEventListener('DOMContentLoaded', function() {
    // Star rating
    const stars = document.querySelectorAll('.star-rating .star');
    const ratingInput = document.getElementById('reviewRating');
    let selectedRating = 0;

    function updateStars(rating) {
        stars.forEach((star, index) => {
            star.classList.toggle('selected', index < rating);
        });
    }

    stars.forEach(star => {
        const value = parseInt(star.dataset.value);

        star.addEventListener('mouseenter', () => updateStars(value));
        star.parentElement.addEventListener('mouseleave', () => updateStars(selectedRating));
        star.addEventListener('click', () => {
            selectedRating = value;
            ratingInput.value = value;
            updateStars(selectedRating);
        });
    });

    if (ratingInput.value) {
        selectedRating = parseInt(ratingInput.value);
        updateStars(selectedRating);
    }

    // AJAX review form submission
    const reviewForm = document.getElementById('newReviewForm');
    if (reviewForm) {
        reviewForm.addEventListener('submit', async function(e) {
            e.preventDefault();
            const formData = new FormData(this);
            const submitBtn = this.querySelector('.submit-review-btn');
            submitBtn.textContent = 'Enviando...';
            submitBtn.disabled = true;

            try {
                const res = await fetch('api/review.php', { method: 'POST', body: formData });
                const data = await res.json();

                if (data.success) {
                    this.reset();
                    ratingInput.value = '';
                    selectedRating = 0;
                    updateStars(selectedRating);

                    const gameId = document.getElementById('reviewGameId').value;
                    await loadGameReviews(gameId);

                    if (data.avg_rating !== undefined) {
                        document.getElementById('gameRating').textContent = data.avg_rating;
                    }
                } else alert('Error: ' + data.message);
            } catch (err) {
                console.error(err);
                alert('Error al enviar la reseña');
            } finally {
                submitBtn.textContent = 'Enviar Reseña';
                submitBtn.disabled = false;
            }
        });

        // Submit on Enter key
        document.getElementById('reviewContent').addEventListener('keydown', function(e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                reviewForm.requestSubmit();
            }
        });
    }
});

let currentSlide = 0;
const slides = document.querySelectorAll('.carousel-slide');

function showSlide(index) {
    slides.forEach((s, i) => s.classList.toggle('active', i === index));
}

document.querySelector('.banner-carousel .next').addEventListener('click', () => {
    currentSlide = (currentSlide + 1) % slides.length;
    showSlide(currentSlide);
});

document.querySelector('.banner-carousel .prev').addEventListener('click', () => {
    currentSlide = (currentSlide - 1 + slides.length) % slides.length;
    showSlide(currentSlide);
});

// Auto slide cada 5 segundos
setInterval(() => {
    currentSlide = (currentSlide + 1) % slides.length;
    showSlide(currentSlide);
}, 5000);

// Mostrar la primera
showSlide(currentSlide);



