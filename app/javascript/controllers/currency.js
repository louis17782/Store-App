let currency = window.APP_CURRENCY || "usd"

window.setCurrency = function(type){
  currency = type
   fetch(`/set_currency/${type}`, {
    method: "POST",
    headers: {
      "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
    }
  }).then(() => {
    updatePrices()
  })
}

window.updatePrices = function(){

  document.querySelectorAll(".product").forEach(product => {

    const usd = product.dataset.usd
    const bs = product.dataset.bs
    const price = product.querySelector(".price")

    if(currency === "usd"){
      price.innerText = "$" + usd
    }else{
      price.innerText = "Bs " + bs
    }

  })

}
document.addEventListener("DOMContentLoaded", () => {
  updatePrices()
})


