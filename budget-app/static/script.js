const items = document.querySelectorAll(".transaction-item");
const button = document.getElementById("showMoreBtn");

let visible = 3;

// hide all after first 3
function updateList() {
    items.forEach((item, index) => {
        if (index < visible) {
            item.style.display = "block";
        } else {
            item.style.display = "none";
        }
    });

    // hide button if not enough items
    if (items.length <= 3) {
        button.style.display = "none";
        return;
    }

    button.style.display = "inline-block";

    if (visible >= items.length) {
        button.textContent = "Show Less";
    } else {
        button.textContent = "Show More";
    }
}

// first load
updateList();

// show 3 more
button.addEventListener("click", () => {
    if (visible >= items.length) {
        // SHOW LESS
        visible = 3;
    } else {
        // SHOW MORE
        visible += 3;
    }
    updateList();
});