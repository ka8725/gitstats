module Gitstats
  class Shitometer
    def self.call(env)
      filelist = `git ls-files --exclude-standard`.split.reject {|x| x =~ /(^vendor)|(^public\/images)|(^public\/stylesheets)/}
      res = {}
      filelist.map do |file|
        blamelist = `git blame -e #{file} | cut -d' ' -f 2`.split.map do |line|
          line.gsub!(/[()<>]/, '')
        end.compact.sort.group_by(&:to_s).map do |email, group|
          res[email] ||= 0; res[email] += group.size
        end
      end
      res = res.to_a.sort {|a,b| b.last <=> a.last}
      [
        200,
        {'Content-Type'=>'text/html'},
        <<-EOB
          <html>
          <head>
            <!--Load the AJAX API-->
            <script type="text/javascript" src="https://www.google.com/jsapi"></script>
            <script type="text/javascript">

              // Load the Visualization API and the piechart package.
              google.load('visualization', '1.0', {'packages':['corechart', 'table']});

              // Set a callback to run when the Google Visualization API is loaded.
              google.setOnLoadCallback(drawChart);

              // Callback that creates and populates a data table,
              // instantiates the pie chart, passes in the data and
              // draws it.
              function drawChart() {

              // Create the data table.
              data = new google.visualization.DataTable();
              data.addColumn('string', 'Developer');
              data.addColumn('number', 'Count strings');
              items = #{res.to_json};
              data.addRows(items);
              // Set chart options
              var options = {'title':'Git stats',
                             'width':700,
                             'height':600};
              // Instantiate and draw our chart, passing in some options.
              var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
              chart.draw(data, options);
              var table = new google.visualization.Table(document.getElementById('table_div'));
              table.draw(data, {showRowNumber: true});
              google.visualization.events.addListener(table, 'select', function() {
                var row = table.getSelection()[0].row;
                alert('You selected ' + data.getValue(row, 0));
              });
            }
            </script>
          </head>

          <body>
            <!--Div that will hold the pie chart-->
            <div id="table_div"></div>
            <br />
            <div id="chart_div" styles="margin:auto"></div>
          </body>
        </html>
        EOB
      ]
    end
  end
end