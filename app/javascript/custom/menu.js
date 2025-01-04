function addListener(firstSelector, secondSelector, action){
    let el = document.querySelector(firstSelector);
    el.addEventListener("click", (e) => {
        e.preventDefault()
        let menu = document.querySelector(secondSelector);
        menu.classList.toggle(action);
    });
}
// Add toggle listeners to listen for clicks

document.addEventListener("turbo:load", function() {
    // This is for the hamburger menu dropdown


    addListener("#hamburger", "#navbar-menu", "collapse");
    addListener("#account", "#dropdown-menu", "active")


    // let hamburger = document.querySelector("#hamburger");
    // hamburger.addEventListener("click", (e) => {
    //     e.preventDefault()
    //     let menu = document.querySelector("#navbar-menu");
    //     menu.classList.toggle("collapse");
    // });
    //
    // //This is for the account menu dropdown
    // let account = document.querySelector("#account");
    // account.addEventListener("click", (event) =>{
    //     event.preventDefault()
    //     let menu = document.querySelector("#dropdown-menu");
    //     menu.classList.toggle("active");
    // });
});