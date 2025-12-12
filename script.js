// Hamburger menu functionality

document.getElementById("adumYear").textContent = new Date().getFullYear();


document.addEventListener('DOMContentLoaded', function() {
    const hamburger = document.querySelector('.hamburger');
    const navMenu = document.querySelector('.navbar ul');
  
    
    if (hamburger && navMenu) {
        hamburger.addEventListener('click', function() {
            hamburger.classList.toggle('active');
            navMenu.classList.toggle('active');
        });

        // Close menu when clicking on a link
        const navLinks = document.querySelectorAll('.navbar ul li a');
        navLinks.forEach(link => {
            link.addEventListener('click', function() {
                hamburger.classList.remove('active');
                navMenu.classList.remove('active');
            });
        });

        // Close menu when clicking outside
        document.addEventListener('click', function(event) {
            const isClickInsideNav = navMenu.contains(event.target) || hamburger.contains(event.target);
            if (!isClickInsideNav && navMenu.classList.contains('active')) {
                hamburger.classList.remove('active');
                navMenu.classList.remove('active');
            }
        });
    }

    function initMapWhenReady() {
        if (typeof L === 'undefined') {

            setTimeout(initMapWhenReady, 50);
            return;
        }

        
        var map = L.map('map').setView([46.559158, 15.643338], 13); 

        
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        
        L.marker([46.559158, 15.643338]).addTo(map)
          .bindPopup('Slomškov trg 15, Maribor').openPopup();
    }

    initMapWhenReady();
});

document.addEventListener('DOMContentLoaded', function() {
  const poslanstvo = document.getElementById('poslanstvo');
  const poslanstwoParagraph = poslanstvo.querySelector('p');
  const hero = document.getElementById('hero');
  const wrapper = document.querySelector('.poslanstvo_wrapper');
  const kodsmo = document.getElementById('kodsmo');
  const after_poslanstvo = document.getElementById('after_poslanstvo');
  
  if (poslanstvo && poslanstwoParagraph && hero && wrapper) {
 
    function positionPoslanstvo() {
      const heroHeight = hero.offsetHeight;
      const poslanstoHeight = poslanstvo.offsetHeight;
      const wrapperHeight = wrapper.offsetHeight;
      
      console.log('Hero Height:', heroHeight);
      console.log('Poslanstvo Height:', poslanstoHeight);
   


      kodsmo.style.paddingBottom = `${poslanstoHeight / 2 }px`;
      after_poslanstvo.style.marginTop = `${poslanstoHeight / 2 }px`;
      
    
    }
    
    positionPoslanstvo();
    
    
    window.addEventListener('resize', positionPoslanstvo);
  }
});