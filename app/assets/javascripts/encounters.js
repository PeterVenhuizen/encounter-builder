jQuery(function() {

    // copy the hidden form monsters to the div outside the form where they are visible
    cloneMonsters();

    // update when a monster is removed
    $(document)
        .on('cocoon:after-insert', function() {
            const monsters = document.querySelector('.monsters');
            ($('.monster-fields').last().detach()).appendTo(monsters);
            calcEncounterStats();
            cloneMonsters();
        })
        .on('cocoon:after-remove', function(e, item) {
            calcEncounterStats();
            cloneBack();
        });

    // update if the party changes or the monster settings
    $('.encounter-form').on('change', 'select', function() {
        calcEncounterStats();
        getPartyStats();
    });

    // update group size
    $(document).on('click', '.plus, .minus', function(e) {
        setGroupSize(e, this);
        cloneBack();
        calcEncounterStats();
    });

    // copy the submit button value
    $('.alternative-submit').text($('.encounter-form input[type="submit"]').val());

    // submit form via alternative button
    $(document).on('click', '.alternative-submit', function(e) {
        $('.encounter-form').trigger('submit');
    });

});

getPartyStats = () => {
    const partySelect = document.querySelector('.party-select');
    $.ajax({
        type: 'GET',
        url:  `party_stats/${partySelect.value}`
    });
}

calcEncounterStats = () => {
    const partySelect = document.querySelector('.party-select');
    let monsters = document.querySelectorAll('.encounter-form .monster-fields');

    // ignore to be deleted monsters
    monsters = [...monsters].filter(m => m.style.display !== 'none');

    fates = [...monsters].map(m => ({
        ['group_size']: m.querySelector('.group_size').value,
        ['monster_id']: m.querySelector('.monster_id').value
    }));

    $.ajax({
        type: 'GET',
        url: `encounter_stats?party_id=${partySelect.value}&fates_attributes=${JSON.stringify(fates)}` 
    });
}

async function getData(url = '', data = {}) {
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
}

resetSearch = () => {
    document.getElementById('search').value = '';
    document.querySelector('.search-monsters-results').innerHTML = '';
}

cloneMonsters = function() {
    $('.monsters-copy').html($('.encounter-monsters').children().clone());
}

cloneBack = function() {
    $('.encounter-monsters').html($('.monsters-copy').children().clone());
}