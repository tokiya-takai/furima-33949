function item() {
  const itemPrice = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  let addTax;
  let tax = 0.1;

  itemPrice.addEventListener('change', () => {
    let price = itemPrice.value;
    addTax = Math.floor(price * tax);
    addTaxPrice.innerHTML = addTax;
    profit.innerHTML = Math.floor(price - addTax);
  });
}
window.addEventListener('load', item);