document.getElementById("incident-form").addEventListener("submit", function(e) {
    e.preventDefault();
    let name = document.getElementById("name").value.toLowerCase();
    let contact = document.getElementById("contact").value;
    let type = document.getElementById("type").value.toLowerCase();
    let severity = document.getElementById("severity").value.toLowerCase();
    let location = document.getElementById("location").value.toLowerCase();
    let table = document.getElementById("incident-table").getElementsByTagName('tbody')[0];
    let row = table.insertRow();
    row.insertCell(0).innerHTML = table.rows.length;
    row.insertCell(1).innerHTML = type;
    row.insertCell(2).innerHTML = severity;
    row.insertCell(3).innerHTML = location;
    row.insertCell(4).innerHTML = new Date().toLocaleString();
    row.insertCell(5).innerHTML = "reported";
    row.insertCell(6).innerHTML = name;
    this.reset();
});
