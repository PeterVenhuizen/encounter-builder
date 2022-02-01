jQuery(function() {
    const partySelect = document.querySelector('.party-select');
    const authenticityToken = document.querySelector('input[name="authenticity_token"]').value;
    console.log(authenticityToken);
    
    calcEncounterStats(partySelect, authenticityToken);

    // update when a monster is removed
    $(document)
        .on('cocoon:after-insert', function() {
            const monsters = document.querySelector('.monsters');
            ($('.monster-fields').last().detach()).appendTo(monsters);
            calcEncounterStats(partySelect, authenticityToken);
            resetSearch();
        })
        .on('cocoon:after-remove', function() {
            calcEncounterStats(partySelect, authenticityToken);
        });

    // update if the party changes or the monster settings
    $('.encounter-form').on('change', 'select, input[type="number"]', function() {
        calcEncounterStats(partySelect, authenticityToken);

        if (this.classList.contains('party-select'))
            // getPartyStats(partySelect, authenticityToken);
            getPartyStats(partySelect);
    });

    // update group size
    $(document).on('click', '.plus, .minus', function(e) {
        setGroupSize(e, this);
        calcEncounterStats(partySelect, authenticityToken);
    });

    // copy the submit button value
    $('.alternative-submit').text($('.encounter-form input[type="submit"]').val());
    console.log($('.encounter-form input[type="submit"]').val());

    // submit form via alternative button
    $(document).on('click', '.alternative-submit', function(e) {
        $('.encounter-form').trigger('submit');
    });

});

// getPartyStats = (partySelect, authenticityToken) => {
getPartyStats = (partySelect) => {
    $.ajax({
        type: 'GET',
        url:  `party_stats/${partySelect.value}`
    });
}

calcEncounterStats = (partySelect, authenticityToken) => {
    let monsters = document.querySelectorAll('.monster-fields');

    // ignore to be deleted monsters
    monsters = [...monsters].filter(m => m.style.display !== 'none');

    postData('calculate_stats', 
        {
            authenticity_token: authenticityToken,
            party_id: partySelect.value,
            monsters: [...monsters].map(m => ({
                ['group_size']: m.querySelector('.group_size').value,
                ['id']: m.querySelector('.monster_id').value
            }))
        })
        .then(data => {
            console.log(data);
            const encounterStats = document.getElementById('encounter-stats');
            const template = document.getElementById('encounter-stats-template');
            const clone = template.content.cloneNode(true);

            const largePill = clone.querySelector('.large-pill');
            largePill.classList.add(data.difficulty);
            largePill.textContent = data.difficulty;

            // to-do: adjust width of difficulty bar

            clone.querySelector('.total-xp').textContent = data.total_experience
            clone.querySelector('.adjusted-xp').textContent = data.adjusted_experience
            clone.querySelector('.multiplier').textContent = data.multiplier

            encounterStats.innerHTML = '';
            encounterStats.appendChild(clone);
        })
        .catch(error => {
            defaultData = {multiplier: 1, difficulty: 'none', total_experience: 0, adjusted_experience: 0};
        });
}

async function postData(url = '', data = {}) {
    // console.log(data);
    const response = await fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    });
    return response.json();
}

async function getData(url = '', data = {}) {
    // console.log(data);
    const response = await fetch(url, {
        method: 'GET',
        headers: {
            'Content-Type': 'text/html'
        }
    });
}

setGroupSize = (e, element) => {
    e.preventDefault();

    // get the group-size elements
    const visibleGroupSize = element.parentElement.querySelector('.group-size-value');
    const hiddenGroupSize = element.closest('.monster-fields').querySelector('.group_size');

    let groupSize = parseInt(hiddenGroupSize.value);

    if (element.classList.contains('minus')) {

        if (groupSize > 1) {
            visibleGroupSize.textContent = groupSize - 1;
            hiddenGroupSize.value = groupSize - 1;
        }

    } else {
        visibleGroupSize.textContent = groupSize + 1;
        hiddenGroupSize.value = groupSize + 1;
    }

    console.log(groupSize);

    console.log(element);
}

resetSearch = () => {
    document.getElementById('search').value = '';
    document.querySelector('.search-monsters-results').innerHTML = '';
}