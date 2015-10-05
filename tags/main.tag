<main>
  <script src="../bower_components/jquery/dist/jquery.min.js" charset="utf-8"></script>
  <script src="../bower_components/bootstrap/dist/js/bootstrap.min.js" charset="utf-8"></script>
  <link rel="stylesheet" href="../bower_components/bootstrap/dist/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
  <h2>Semana atual: {currentWeek}</h2>
<hr>

<div class="table-responsive">
  <table class="table table-bordered table-hover">
    <thead>
      <tr>
      <td># semana</td><td>seg</td><td>ter</td><td>qua</td><td>qui</td><td>sex</td><td>sáb</td><td>dom</td><td>total semana</td><td>peso</td><td>alterar peso</td>
      </tr>
    </thead>
    <tbody>
      <tr ng-repeat="r in rows">
        <td>{this.week}</td>
        <td data-week={this.week} data-day='1'>{this.monday}</td>
        <td data-week={this.week} data-day='2'>{this.tuesday}</td>
        <td data-week={this.week} data-day='3'>{this.wednesday}</td>
        <td data-week={this.week} data-day='4'>{this.thursday}</td>
        <td data-week={this.week} data-day='5'>{this.friday}</td>
        <td data-week={this.week} data-day='6'>{this.saturday}</td>
        <td data-week={this.week} data-day='7'>{this.sunday}</td>
        <td>{this.total}</td>
        <td>{this.weight}</td>
        <td><input type="number" ng-model="weightInput[r.week]" ng-change="setWeight()" width="3" size="3"></td>
      </tr>
    </tbody>
   </table>
</div>

<form class="form-horizontal" role="form">
  <div class="form-group">
    <label class="control-label col-sm-2" for="weekInput">Semana:</label>
    <div class="col-sm-10">
      <input type="number" name="weekInput" id="weekInput" value="{this.weekInput}" onchange={setWeekInput} placeholder="Digite a semana"></br>
    </div>
  </div>

  <div class="form-group">
    <label class="control-label col-sm-2" for="dayOfWeekInput">Dia da semana:</label>
    <div class="col-sm-10">
      <select name="dayOfWeekInput" id="dayOfWeekInput">
         <option each={weekDays} value={id}>{name}</option>
      </select>
    </div>
  </div>

  <div class="form-group">
    <label class="control-label col-sm-2" for="TaskSelector">Atividade:</label>
    <div class="col-sm-10">
      <select id="TaskSelector" size="15" onchange={setPointsInput} >
           <option each={tasks} value={id}>{descr}</option>
      </select>
    </div>
  </div>

  <div class="form-group">
    <label class="control-label col-sm-2" for="amountInput">Quantidade:</label>
    <div class="col-sm-10">
      <input type="number" ng-model="amountInput" id="amountInput" ng-change="setPointsInput()">
    </div>
  </div>

  <div class="form-group">
    <label class="control-label col-sm-2" for="pointsInput">Pontos:</label>
    <div class="col-sm-10">
      <input type="number" ng-model="pointsInput" id="pointsInput" readonly=true>
    </div>
  </div>

</form>
  <div class="col-sm-4">
    <button class="btn btn-default" ng-click="addTask()" >
      Guardar
    </button>
    <!-- <button class="btn btn-default" ng-click="clearData()" >
      Limpar memória
    </button>
    <button class="btn btn-default" ng-click="saveData()" >
      Salvar na nuvem
    </button>
    <button class="btn btn-default" ng-click="loadData()" >
      Carregar dados da nuvem
    </button>  -->
    <button class="btn btn-default" ng-click="renderResults()" >
      Atualizar tela
    </button>
  </div>
</form>

var v = this;
var data = new Firebase('https://radiant-torch-5597.firebaseio.com/');
v.currentWeek = getWeekNumber()
v.weekInput = v.currentWeek
v.amountInput.value = 1

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

v.weekDays = [
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

  //{taskId:,  week:, dayOfWeek:, points:}
  v.dayTasks = [];
  v.daySum = [];
  v.weekWeight = [];
  v.registeredWeeks = [];
  v.today = new Date();
  v.todayDayOfWeek =  ( ((v.today.getDay() + 6) % 7 ) + 1) ; //monday = 1, sunday = 7

  v.dayOfWeekInput.weekDays = v.todayDayOfWeek;
  v.amountInput = 1;
  v.setWeight = function(){
    week = v.registeredWeeks[this.$index] ;
    v.weekWeight[week]=parseInt(v.weightInput[week]);
    v.saveData();
    console.log(v.weekWeight);
  }
  loadDataFromFirebase();

//////////////////// Start of Methods \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  function renderResults(){
    v.dayTasks.sort(compareDayTask);
    setDaySum();
    setRegisteredWeeks();
    v.rows = [];
    console.log(v.registeredWeeks);
    for(var i=0; i < v.registeredWeeks.length; ++i){
       v.renderWeek(v.registeredWeeks[i]);
    }
  }

  function setDaySum(){
    v.daySum = [];
    console.log(v.dayTasks);
    for (var j = 0; j < v.dayTasks.length; j++){
      var i = v.dayTasks[j];
      if(v.daySum[i.week] === undefined)
        v.daySum[i.week]=[];
      if(v.daySum[i.week][i.dayOfWeek] === undefined)
        v.daySum[i.week][i.dayOfWeek]=0;
      v.daySum[i.week][i.dayOfWeek]+=i.points;
      console.log(v.daySum[i.week][i.dayOfWeek]);
     }
    console.log(v.daySum);
  };

  function setRegisteredWeeks(){
    v.registeredWeeks = [];
    lastWeek=-1;
    for (var j = 0; j < v.dayTasks.length; j++){
      var i=v.dayTasks[j];
      if(lastWeek!=i.week){
        v.registeredWeeks.push(i.week);
      }
      lastWeek=i.week;
    }
  }

  function loadDataFromFirebase(){
      data.once("value", function(snapshot) {
        dataSet=snapshot.val();
        v.dayTasks = dataSet.tasks;
        v.weekWeight = dataSet.weights;
        console.log(dataSet);
        //v.messages = JSON.stringify(dataSet);
        renderResults();
      }, function (err){
        alert("Erro carregando dados da nuvem");
      });
  };

  function compareDayTask(a,b) {
    if (a.week < b.week)
      return -1;
    if (a.week > b.week)
      return 1;
    if(a.dayOfWeek < b.dayOfweek)
       return -1;
    if(a.dayOfWeek > b.dayOfweek)
       return 1;
    return 0;
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

</main>
