<main>
  <script src="../bower_components/jquery/dist/jquery.min.js" charset="utf-8"></script>
  <script src="../bower_components/bootstrap/dist/js/bootstrap.min.js" charset="utf-8"></script>
  <link rel="stylesheet" href="../bower_components/bootstrap/dist/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
  <h2>current week: {this.weekNumber}</h2>
<hr>

<form class="form-horizontal" role="form">
  <div class="form-group">
    <label class="control-label col-sm-2" for="weekInput">Semana:</label>
    <div class="col-sm-10">
      <input type="number" name="weekInput" id="weekInput" value="{this.weekInput}" onchange={setWeekInput} placeholder="Digite a semana"></br>
    </div>
  </div>
</form>
var v = this;
v.weekNumber = getWeekNumber()
v.weekInput = v.weekNumber;




// Add new tasks to the end
// Do not change the order since it task has a hidden id value
v.tasks=[
  {descr: 'Prato 50% verdura +2', points: 2},
  {descr: 'Ir para academia +2', points: 2},
  {descr: 'Cama < 22:30hs +2', points: 2},
  {descr: 'comer < 500g +2', points: 2},
  {descr: 'Escovar dentes 3x dia +1', points: 1},
  {descr: 'Merendar frutras +2', points: 2},
  {descr: 'Ir de bike para o trabalho +2', points: 2},
  {descr: 'Usar programa do sono +2', points: 2},
  {descr: 'Tomar suco detox +2', points: 2},
  {descr: 'comer > 600g -2', points: -2},
  {descr: 'Merendar carboidrato -2', points: -2},
  {descr: 'Dormir < 7hs -3', points: -3},
  {descr: 'Carboidrato depois 18hs -3', points: -3},
  {descr: 'Beber 600ml de cerveja -2', points: -2},
  {descr: 'Beber durante a semana -10', points: -10},
  {descr: 'Fds inteiro sem beber (sex-dom) +100', points: 100},
  {descr: 'Não beber de segunda a quinta +50', points: 50},
  {descr: 'Não beber por um dia no fds +30', points: 30},
  {descr: 'Fazer a ficha completa da academia +10',points: 10},
  {descr: 'Comer sobremesa -5',points: -5},
];
v.dayOfWeekInput = {};

v.dayOfWeekInput.weekDaysArr = [
    { id: 1, name: 'Segunda' },
    { id: 2, name: 'Terça' },
    { id: 3, name: 'Quarta' },
    { id: 4, name: 'Quinta' },
    { id: 5, name: 'Sexta' },
    { id: 6, name: 'Sábado' },
    { id: 7, name: 'Domingo' },
];

  //Initializes the ids for the tasks
  var id = -1
  //Adds ids for the tasks
  for (var i = 0; i < v.tasks.length; i++) {
    v.tasks[i].id = ++id
  }

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

  setWeekInput(e) {
    v.weekInput = e.target.value
  }

  console.log(v.tasks)

</main>
