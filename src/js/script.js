function openGameModal(gameId, title, cover, platforms, genres, rating) {
    document.getElementById('gameTitle').textContent = title;
    document.getElementById('gamePlatforms').textContent = platforms;
    document.getElementById('gameGenres').textContent = genres;
    document.getElementById('gameRating').textContent = rating;
    document.getElementById('reviewGameId').value = gameId;

    // Cover
    const coverImg = document.getElementById('gameCover');
    if (cover && cover.trim() !== '') {
        coverImg.src = cover;
        coverImg.style.display = 'block';
    } else {
        coverImg.style.display = 'none';
    }

    // Load reviews
    loadGameReviews(gameId);

    // Load favorite status
    loadFavoriteStatus(gameId);

    // Show modal
    document.getElementById('gameModal').style.display = 'block';
}

function closeGameModal() {
    document.getElementById('gameModal').style.display = 'none';
    document.getElementById('newReviewForm').reset();
}

function loadGameReviews(gameId) {
    const container = document.getElementById('reviewsContainer');
    container.innerHTML = '<div class="no-reviews">Cargando reseñas...</div>';

    fetch(`api/get_reviews.php?gameid=${gameId}`)
        .then(response => response.json())
        .then(data => {
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
        })
        .catch(error => {
            console.error('Error loading reviews:', error);
            container.innerHTML = '<div class="no-reviews">Error al cargar las reseñas.</div>';
        });
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

// Handle new review form submission
document.getElementById('newReviewForm')?.addEventListener('submit', function (e) {
    e.preventDefault();

    const formData = new FormData(this);
    const submitBtn = this.querySelector('.submit-review-btn');
    const originalText = submitBtn.textContent;

    submitBtn.textContent = 'Enviando...';
    submitBtn.disabled = true;

    fetch('api/review.php', {
        method: 'POST',
        body: formData
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                loadGameReviews(document.getElementById('reviewGameId').value);
                this.reset();
                alert('Reseña enviada exitosamente!');
            } else {
                alert('Error: ' + data.message);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Error al enviar la reseña');
        })
        .finally(() => {
            submitBtn.textContent = originalText;
            submitBtn.disabled = false;
        });
});

// Close modal when clicking outside
window.onclick = function (event) {
    const modal = document.getElementById('gameModal');
    if (event.target === modal) {
        closeGameModal();
    }
};

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

                // Attach event listener once
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

// ⭐ Estrellas de calificación (rating interactivo)
document.addEventListener('DOMContentLoaded', () => {
    const stars = document.querySelectorAll('.star-rating .star');
    const ratingInput = document.getElementById('reviewRating');

    if (!stars.length || !ratingInput) return;

    let selectedRating = 0;

    stars.forEach(star => {
        const value = parseInt(star.dataset.value);

        star.addEventListener('mouseenter', () => {
            stars.forEach(s => s.classList.remove('hover'));
            for (let i = 0; i < value; i++) {
                stars[i].classList.add('hover');
            }
        });

        star.parentElement.addEventListener('mouseleave', () => {
            stars.forEach(s => s.classList.remove('hover'));
        });

        star.addEventListener('click', () => {
            selectedRating = value;
            ratingInput.value = value;

            stars.forEach(s => s.classList.remove('selected'));
            for (let i = 0; i < value; i++) {
                stars[i].classList.add('selected');
            }
        });
    });
});

// Agregar funcionalidad de clic para navegadores sin soporte :has()
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('fieldset label').forEach(label => {
        label.addEventListener('click', function(e) {
            const checkbox = this.querySelector('input[type="checkbox"]');
            if (checkbox) {
                // Cambiar estado del checkbox
                checkbox.checked = !checkbox.checked;
                
                // Aplicar estilos manualmente para compatibilidad
                if (checkbox.checked) {
                    this.style.backgroundColor = '#1c9eff';
                    this.style.borderColor = 'white';
                    this.style.fontWeight = 'bold';
                } else {
                    this.style.backgroundColor = '#0a264d';
                    this.style.borderColor = 'transparent';
                    this.style.fontWeight = 'normal';
                }
            }
        });
        
        // Aplicar estilo inicial si ya está checked
        const checkbox = label.querySelector('input[type="checkbox"]');
        if (checkbox && checkbox.checked) {
            label.style.backgroundColor = '#1c9eff';
            label.style.borderColor = 'white';
            label.style.fontWeight = 'bold';
        }
    });
});