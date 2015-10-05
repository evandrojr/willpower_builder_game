<main>
<%--
  <script src="bower_components/bootstrap/dist/js/bootstrap.min.js" charset="utf-8"></script>
  <link rel="stylesheet" href="bower_components/bootstrap/dist/js/bootstrap.min.js" media="screen" title="no title" charset="utf-8">
 --%>
<h3>Current week: {currentWeek} </h3>


function getWeekNumber() {
    // Copy date so don't modify original
    var d = new Date();
    d.setHours(0,0,0);
    // Set to nearest Thursday: current date + 4 - current day number
    // Make Sunday's day number 7
    d.setDate(d.getDate() + 4 - (d.getDay()||7));
    // Get first day of year
    var yearStart = new Date(d.getFullYear(),0,1);
    // Calculate full weeks to nearest Thursday
    var weekNo = Math.ceil(( ( (d - yearStart) / 86400000) + 1)/7);
    // Return array of year and week number
    return weekNo;
}

currentWeek = getWeekNumber()


</main>
