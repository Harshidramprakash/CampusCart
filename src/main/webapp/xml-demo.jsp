<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="header.jsp" />

<div class="container" style="padding-top: 2rem;">
    <h2>XML Data Loading Demo</h2>
    <p>This page demonstrates loading an XML document from the server using AJAX and parsing it into an HTML table (Experiment 7).</p>
    
    <button class="btn btn-primary" onclick="loadXMLDoc()">Load XML Data</button>
    
    <div style="margin-top: 2rem;">
        <table class="data-table" id="xmlTable" style="display:none;">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Product Name</th>
                    <th>Category</th>
                    <th>Price (₹)</th>
                    <th>Stock</th>
                </tr>
            </thead>
            <tbody>
                <!-- Populated by JavaScript -->
            </tbody>
        </table>
    </div>
</div>

<script>
function loadXMLDoc() {
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            parseXMLAndRender(this);
        }
    };
    xhttp.open("GET", "${pageContext.request.contextPath}/xml/products.xml", true);
    xhttp.send();
}

function parseXMLAndRender(xml) {
    var xmlDoc = xml.responseXML;
    var table = document.getElementById("xmlTable");
    var tbody = table.getElementsByTagName("tbody")[0];
    tbody.innerHTML = ""; // Clear existing
    
    var products = xmlDoc.getElementsByTagName("product");
    
    for (var i = 0; i < products.length; i++) {
        var id = products[i].getElementsByTagName("id")[0].childNodes[0].nodeValue;
        var name = products[i].getElementsByTagName("name")[0].childNodes[0].nodeValue;
        var category = products[i].getElementsByTagName("category")[0].childNodes[0].nodeValue;
        var price = products[i].getElementsByTagName("price")[0].childNodes[0].nodeValue;
        var stock = products[i].getElementsByTagName("stock")[0].childNodes[0].nodeValue;
        
        var tr = document.createElement("tr");
        tr.innerHTML = "<td>" + id + "</td>" +
                       "<td>" + name + "</td>" +
                       "<td>" + category + "</td>" +
                       "<td>" + price + "</td>" +
                       "<td>" + stock + "</td>";
        tbody.appendChild(tr);
    }
    
    table.style.display = "table";
}
</script>

<jsp:include page="footer.jsp" />
