<html>
  <head>
    <meta http-equiv="refresh" content="5" >
    <title>Monitoring</title>

	<style>
            table {
                border-collapse: collapse;
                border: 2px black solid;
                font: 12px sans-serif;
            }

            td {
                border: 1px black solid;
                padding: 5px;
            }
        </style>
  </head>
  
  <body style="background: url(bg.png) no-repeat; background-size: 100%"; text="#568880">
    <h1>Web server's log:</h1>

	<div>
 	<?php include("basic_monitoring.log"); ?>
	</div>
	

        <script src="d3.v3.min.js"></script>
        <script src="d3.min.js?v=3.2.8"></script>

        <script type="text/javascript"charset="utf-8">
            d3.text("data.csv", function(data) {
                var parsedCSV = d3.csv.parseRows(data);

                var container = d3.select("body")
                    .append("table")

                    .selectAll("tr")
                        .data(parsedCSV).enter()
                        .append("tr")

                    .selectAll("td")
                        .data(function(d) { return d; }).enter()
                        .append("td")
                        .text(function(d) { return d; });
            });
        </script>

        <script src="d3.min.js?v=3.2.8"></script>

	<br><br>	
	
        <script type="text/javascript"charset="utf-8">
            d3.text("ip.csv", function(data) {
                var parsedCSV = d3.csv.parseRows(data);

                var container = d3.select("body")
                    .append("table")

                    .selectAll("tr")
                        .data(parsedCSV).enter()
                        .append("tr")

                    .selectAll("td")
                        .data(function(d) { return d; }).enter()
                        .append("td")
                        .text(function(d) { return d; });
            });
        </script>

  </body>
</html>
