<main>
  <script src="../bower_components/jquery/dist/jquery.min.js" charset="utf-8"></script>
  <script src="../bower_components/bootstrap/dist/js/bootstrap.min.js" charset="utf-8"></script>
  <link rel="stylesheet" href="../bower_components/bootstrap/dist/css/bootstrap.min.css" media="screen" title="no title" charset="utf-8">
  <h5>Semana atual: {currentWeek}</h5>
<hr>

<div class="table-responsive">
  <table class="table table-bordered table-hover">
    <thead>
      <tr>
      <td># semana</td><td>seg</td><td>ter</td><td>qua</td><td>qui</td><td>sex</td><td>sáb</td><td>dom</td><td>total semana</td><td>peso</td>
      </tr>
    </thead>
    <tbody>
      <tr each={calendar}>
        <td>{week}</td>
        <td onmouseover={mouseOverCalendarCell} data-week={this.week} data-day='1'>{monday}</td>
        <td onmouseover={mouseOverCalendarCell} data-week={this.week} data-day='2'>{tuesday}</td>
        <td onmouseover={mouseOverCalendarCell} data-week={this.week} data-day='3'>{wednesday}</td>
        <td onmouseover={mouseOverCalendarCell} data-week={this.week} data-day='4'>{thursday}</td>
        <td onmouseover={mouseOverCalendarCell} data-week={this.week} data-day='5'>{friday}</td>
        <td onmouseover={mouseOverCalendarCell} data-week={this.week} data-day='6'>{saturday}</td>
        <td onmouseover={mouseOverCalendarCell} data-week={this.week} data-day='7'>{sunday}</td>
        <td>{total}</td>
        <td ><input type="number" class="col-md-3"  onchange={setWeight} value={weight} size="3"></td>
      </tr>
    </tbody>
   </table>
</div>

<form class="form-horizontal" role="form">
  <div class="form-group">
    <label class="control-label col-sm-2" for="weekInput">Semana:</label>
    <div class="col-sm-10">
      <input type="number" name="weekInput" id="weekInput" value={currentWeek} onchange={setWeekInput} placeholder="Digite a semana"></br>
    </div>
  </div>

  <div class="form-group">
    <label class="control-label col-sm-2" for="dayOfWeekInput">Dia da semana:</label>
    <div class="col-sm-10">
      <select name="dayOfWeekInput" id="dayOfWeekInput">
         <option each={weekDays} selected={id == todayDayOfWeek} value={id}>{name}</option>
      </select>
    </div>
  </div>

  <div class="form-group">
    <label class="control-label col-sm-2" for="taskSelector">Atividade:</label>
    <div class="col-sm-10">
      <select id="taskSelector" size="15" onchange={setPointsInput} >
           <option each={tasks} selected={id == '0'} value={id}>{descr}</option>
      </select>
    </div>
  </div>

  <div class="form-group">
    <label class="control-label col-sm-2" for="amountInput">Quantidade:</label>
    <div class="col-sm-10">
      <input type="number" id="amountInput" value="1" onchange={setPointsInput} >
    </div>
  </div>

  <div class="form-group">
    <label class="control-label col-sm-2" for="pointsInput">Pontos:</label>
    <div class="col-sm-10">
      <input type="number"  id="pointsInput" readonly=true>
    </div>
  </div>

</form>
  <div class="col-sm-4">
    <button class="btn btn-default" onclick={addTask} >
        Adicionar tarefa
    </button>
    <!-- <button class="btn btn-default" ng-click="clearData()" >
      Limpar memória
    </button>
    <button class="btn btn-default" noclick={saveData} >
      Salvar na nuvem
    </button>
    <button class="btn btn-default" ng-click="loadData()" >
      Carregar dados da nuvem
    </button>
    <button class="btn btn-default" ng-click="renderResults()" >
      Atualizar tela
    </button>
  -->
  </div>
</form>



  var v = this;
  if(Firebase != null){
    var data = new Firebase('https://radiant-torch-5597.firebaseio.com/');
  }else{
    var data = null
  }
  v.currentWeek = getWeekNumber()
  v.weekInput.value = v.currentWeek

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
  v.calendar = []
  v.dayOfWeekInput.weekDays = v.todayDayOfWeek;
  v.pointsInput.value = 2 // Should be v.amountInput.value * v.tasks[v.taskSelector.value].points
  if(Firebase!=null){
    loadDataFromFirebase()
  }
  renderResults()
  ///////////////////////////// Start of Methods \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  setWeight(e){
    week = e.item.week
    v.weekWeight[week]=parseInt(e.currentTarget.value)
    saveData()
    console.log(v.weekWeight)
  }

  function saveData(){
    if(Firebase==null){
      return
    }
    //$scope.localBackup();
    dataSet={tasks: v.dayTasks, weights: v.weekWeight};
    data.set(dataSet);
    console.log(dataSet);
  };

  setPointsInput(){
    //TODO make it better!
    v.pointsInput.value = v.amountInput.value * v.tasks[v.taskSelector.value].points;
  }

  addTask(){
   v.dayTasks.push({taskId: parseInt(v.taskSelector.value), week: parseInt(v.weekInput.value), dayOfWeek: parseInt(v.dayOfWeekInput.value), points: parseInt(v.pointsInput.value) });
   renderResults();
   saveData();
  };

  function renderResults(){
    v.dayTasks.sort(compareDayTask);
    setDaySum();
    setRegisteredWeeks();
    v.calendar = [];
    console.log(v.registeredWeeks);
    for(var i=0; i < v.registeredWeeks.length; ++i){
       renderWeek(v.registeredWeeks[i]);
    }
    v.update()
  }


  function sumWeek(week){
    sum = 0;
    for (var i = 1; i <= 7; i++){
      if(v.daySum[week]!==undefined && v.daySum[week][i]!==undefined)
        sum+=v.daySum[week][i];
    }
    return sum;
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

  function renderWeek(week){
              v.calendar.push({week: week,
                      monday: v.daySum[week][1],
                      tuesday: v.daySum[week][2],
                      wednesday: v.daySum[week][3],
                      thursday: v.daySum[week][4],
                      friday: v.daySum[week][5],
                      saturday: v.daySum[week][6],
                      sunday: v.daySum[week][7],
                      total: sumWeek(week),
                      weight: v.weekWeight[week]
                    });
  };

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
    v.weekInput.value = e.target.value
  }

  mouseOverCalendarCell(e) {
      console.log(e.currentTarget)
      var c = e.currentTarget
      console.log($(c).data('day'))
      var day = $(c).data('day')
      var week = $(c).data('week')
      displayDayActivities(week, day)
  }

  function displayDayActivities(week, day){
    week = parseInt(week)
    day = parseInt(day)
    var activities = ""
    for (var j = 0; j < v.dayTasks.length; j++){
      var i = v.dayTasks[j];
      if(i.week > week)
        break
      if(i.week == week && i.dayOfWeek == day){
        activities+=v.tasks[i.taskId].descr + " " + v.tasks[i.taskId].points + "\n";
      }
    }
    console.log(activities)
    alert(activities)
  }

</main>
