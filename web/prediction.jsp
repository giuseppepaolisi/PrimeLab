<%@page import="it.unisa.gitdm.bean.MyClassifier"%>
<%@page import="it.unisa.gitdm.bean.Project"%>
<%@page import="it.unisa.primeLab.ProjectHandler"%>
<%@page import="it.unisa.gitdm.bean.EvaluationPredictors"%>
<%@page import="java.util.ArrayList"%>
<%@page import="weka.classifiers.trees.RandomForest"%>
<%@page import="weka.classifiers.bayes.NaiveBayes"%>
<%@page import="weka.classifiers.functions.MultilayerPerceptron"%>
<%@page import="weka.classifiers.functions.Logistic"%>
<%@page import="weka.classifiers.rules.DecisionTable"%>
<%@page import="weka.classifiers.Classifier"%>
<%@page import="it.unisa.gitdm.bean.Metric"%>
<%@page import="it.unisa.gitdm.bean.Model"%>
<% double ac = (Double) session.getAttribute("accuracy");%>
<% double pr = (Double) session.getAttribute("precision");%>
<% double re = (Double) session.getAttribute("recall");%>
<% double fm = (Double) session.getAttribute("fmeasure");%>
<% double aur = (Double) session.getAttribute("areaUnderROC");%>
<% Model model = (Model) session.getAttribute("modello");%>
<% ArrayList<EvaluationPredictors> predictors = (ArrayList<EvaluationPredictors>) session.getAttribute("predictors");%>
<% Project project = ProjectHandler.getCurrentProject();%>
<%
    String metricOfModel = "";
    for (Metric m : model.getMetrics()) {
        metricOfModel += m.getNome() + "-";
    }

%>
<%    MyClassifier classifier = model.getClassifier();
%>
<jsp:include page="header.jsp" />
<!-- top navigation -->
<div class="top_nav">
    <div class="nav_menu">
        <nav>

            <!--            <ul class="nav navbar-nav navbar-right">
                            <li class="">
                                <label class="breadcrumb"><a href="#"> Pagina 1 </a> | <a href="#"> Pagina 2 </a> | Pagina 3 </label>
            
                            </li>
                        </ul>-->
        </nav>
    </div>
</div>
<!-- /top navigation -->
<!-- page content -->
<div class="right_col" role="main">
    <div class="">
        <div class="page-title">
        </div>

        <div class="clearfix"></div>


    </div>
    <!-- CONTENT -->
    <div class="row">

        <div class="col-md-12 col-sm-6 col-xs-12">
            <div class="x_panel">
                <div class="x_title">
                    <h2 id="tableTitle">Prediction Summary <small></small></h2>

                    <div class="clearfix"></div>
                </div>
                <div class="x_content">

                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
                        <ul id="myTab1" class="nav nav-tabs bar_tabs right" role="tablist">
                            <li role="presentation" class=""><a href="#history" onclick="document.getElementById('tableTitle').innerHTML = 'History';" id="home-tabb" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">History</a>
                            </li>
                            <li role="presentation" class=""><a href="#prediction" onclick="document.getElementById('tableTitle').innerHTML = 'Prediction';" role="tab" id="profile-tabb" data-toggle="tab" aria-controls="profile" aria-expanded="false">Prediction</a>
                            </li>
                            <li role="presentation" class="active"><a href="#summary" onclick="document.getElementById('tableTitle').innerHTML = 'Prediction Summary';" role="tab" id="profile-tabb3" data-toggle="tab" aria-controls="profile" aria-expanded="false">Summary</a>
                            </li>
                        </ul>
                        <div id="myTabContent2" class="tab-content">
                            <div role="tabpanel" class="tab-pane fade active in" id="summary" aria-labelledby="home-tab">
                                <div class="col-md-12 col-sm-6 col-xs-12">
                                    <div class="x_panel">
                                        <div class="x_title">
                                            <h2>Bar Chart Group <small>Sessions</small></h2>
                                            <ul class="nav navbar-right panel_toolbox">
                                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                                </li>
                                                <li class="dropdown">
                                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                                                    <ul class="dropdown-menu" role="menu">
                                                        <li><a href="#">Settings 1</a>
                                                        </li>
                                                        <li><a href="#">Settings 2</a>
                                                        </li>
                                                    </ul>
                                                </li>
                                                <li><a class="close-link"><i class="fa fa-close"></i></a>
                                                </li>
                                            </ul>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="x_content2">
                                            <div id="graphx" style="width:100%; height:300px;"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div class="x_panel">
                                        <div class="x_title">
                                            <h2>Prediction calculated using: <small>(change fields for new prediction)</small></h2>
                                            <ul class="nav navbar-right panel_toolbox">
                                                <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                                </li>
                                            </ul>
                                            <div class="clearfix"></div>
                                        </div>
                                        <div class="x_content" style="display: block;">
                                            <br>
                                            <form id="demo-form2" data-parsley-validate="" class="form-horizontal form-label-left" novalidate="">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12" for="last-name">Select metrics: <span class="required">*</span>
                                                    </label>
                                                    <div  class="col-md-6 col-sm-6 col-xs-12">
                                                        <div class="col-md-3">
                                                            <div class="checkbox">
                                                                <label name="metric" class="">
                                                                    <input type="checkbox" required="required" class="flat" <% if (metricOfModel.contains("CK Metrics")) {
                                                                            out.print("checked='checked'");
                                                                        }%>> CK metrics
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="checkbox">
                                                                <label name="metric" class="">
                                                                    <input type="checkbox" required="required" class="flat" <% if (metricOfModel.contains("Process")) {
                                                                            out.print("checked='checked'");
                                                                        }%>> Process
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="checkbox">
                                                                <label name="metric" class="">
                                                                    <input type="checkbox" required="required" class="flat" <% if (metricOfModel.contains("Scattering")) {
                                                                            out.print("checked='checked'");
                                                                        }%>> Scattering
                                                                </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <!--                                                            <div class="checkbox">
                                                                                                                            <label name="metric" class="">
                                                                                                                                <input type="checkbox" required="required" class="flat"> Metrica 4
                                                                                                                            </label>
                                                                                                                        </div>-->
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="ln_solid"></div>
                                                <div class="form-group">
                                                    <label class="control-label col-md-3 col-sm-3 col-xs-12">Classifier *</label>
                                                    <div class="col-md-3 col-sm-6 col-xs-12">
                                                        <select id="heard" class="form-control" required="">
                                                            <option value="">Choose...</option>
                                                            <option value="Decision Table Majority" <% if (classifier.getClassifier().getClass() == DecisionTable.class) out.print("selected=''");%>>Decision Table Majority</option>
                                                            <option value="Logistic Regression"<% if (classifier.getClassifier().getClass() == Logistic.class) out.print("selected=''");%>>Logistic Regression</option>
                                                            <option value="Multi Layer Perceptron"<% if (classifier.getClassifier().getClass() == MultilayerPerceptron.class) out.print("selected=''");%>>Multi Layer Perceptron</option>
                                                            <option value="Naive Baesian"<% if (classifier.getClassifier().getClass() == NaiveBayes.class) out.print("selected=''");%>>Naive Baesian</option>
                                                            <option value="Random Forest"<% if (classifier.getClassifier().getClass() == RandomForest.class) out.print("selected=''");%>>Random Forest</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-md-3 col-sm-6 col-xs-12 col-md-offset-3">
                                                        <button type="submit" class="btn btn-success" id="newPred" style="visibility: hidden;">New predicton</button>
                                                    </div>
                                                </div>

                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane fade" id="prediction" aria-labelledby="profile-tab">
                                <div class="x_panel">
                                    <div class="x_title">
                                        <ul class="nav navbar-right panel_toolbox">
                                            <li><button>CSV</button></i></a></li>
                                        </ul>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="x_content col-md-12">
                                        <table id="datatable" class="table table-striped table-bordered">

                                            <thead>
                                                <tr>
                                                    <th>Name</th>
                                                    <th>LOC</th>
                                                    <th>CBO</th>                                            
                                                    <th>LCOM</th>                                         
                                                    <th>NOM</th>
                                                    <th>RFC</th>
                                                    <th>WMC</th>
                                                    <th>changes</th>
                                                    <th>FIChanges</th>
                                                    <th>structuralScatteringSum</th>
                                                    <th>semanticScatteringSum</th>
                                                    <th>developers</th>
                                                    <th>Predicted</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                //AGGIUNGERE ACTUAL IN PREDICTORS.CSV (AL MOMENTO STAMPO SEMPRE TRUE)
                                                    for (EvaluationPredictors p : predictors){
                                                        out.print("<tr><td>"+p.getClassPath()+"</td><td>"+p.getLOC()+"</td><td>"+p.getCBO()+"</td>"
                                                                + "<td>"+p.getLCOM()+"</td><td>"+p.getNOM()+"</td><td>"+p.getRFC()+"</td>"
                                                                + "<td>"+p.getWMC()+"</td><td>"+p.getNumOfChanges()+"</td><td>"+p.getNumberOfFIChanges()+"</td>"
                                                                + "<td>"+p.getStructuralScatteringSum()+"</td><td>"+p.getSemanticScatteringSum()+"</td>"
                                                                + "<td>"+p.getNumberOfDeveloper()+"</td><td>"+p.isIsBuggy()+"</td></tr>");
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div role="tabpanel" class="tab-pane fade" id="history" aria-labelledby="profile-tab">
                                <div class="table-responsive">
                                    <form action="http://localhost:8080/PrimeLabServer/CompareServlet" method="POST" >
                                        <table class="table table-striped jambo_table bulk_action">
                                            <thead>
                                                <tr class="headings">
                                                    <th>
                                                        <input type="checkbox" id="check-all" class="flat">
                                                    </th>
                                                    <th class="column-title">Predictions </th>
                                                    <th>Metrics</th>
                                                    <th>Classifier</th>
                                                    <th class="column-title">Date </th>
                                                    </th>
                                                    <th class="bulk-actions" colspan="7">
                                                        <a class="antoo" style="color:#fff; font-weight:500;"><button type="submit" class="btn btn-primary">Compare</button> ( <span class="action-cnt"> </span> ) <i class="fa fa-chevron-down"></i></a>
                                                    </th>
                                                </tr>
                                            </thead>

                                            <tbody>
                                                <%
                                                    int i = 1;
                                                    for (Model m : project.getModels()){
                                                        if (i % 2 != 0) {
                                                            out.print("<tr class='even pointer'>");
                                                        } else {
                                                            out.print("<tr class='odd pointer'>");
                                                        }
                                                        String metrics = m.getMetrics().toString();
                                                        metrics = metrics.substring(1, metrics.length()-1);
                                                        String classif = m.getClassifier().toString();
                                                        out.print("<td class='a-center'>"
                                                                + "<input type='checkbox' class='flat' name='table_records' value='"+m.getName()+"'>"
                                                                + "</td>"
                                                                + "<td>Run " + i + "</td>"
                                                                + "<td>" + metrics + "</td>"
                                                                + "<td>" + classif + "</td>"
                                                                + "<td>" + m.getDate() + "</td>"
                                                                + "</tr>");
                                                        i++;
                                                    }
                                                    %>


                                            </tbody>
                                        </table>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- /CONTENT -->
</div>


<!-- /page content -->

<!-- footer content -->
<jsp:include page="footer.jsp" />

<!-- iCheck -->
<script src="scripts/icheck.js"></script>
<script src="scripts/parsleyjs/dist/parsley.js"></script>

<script src="scripts/raphael.js"></script>
<script src="scripts/morris.js"></script>
<script src="scripts/datatables.net/js/jquery.dataTables.min.js"></script>

<script src="scripts/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>

<script>
    $(document).ready(function () {
        var handleDataTableButtons = function () {
            if ($("#datatable-buttons").length) {
                $("#datatable-buttons").DataTable({
                    dom: "Bfrtip",
                    buttons: [
                        {
                            extend: "copy",
                            className: "btn-sm"
                        },
                        {
                            extend: "csv",
                            className: "btn-sm"
                        },
                        {
                            extend: "excel",
                            className: "btn-sm"
                        },
                        {
                            extend: "pdfHtml5",
                            className: "btn-sm"
                        },
                        {
                            extend: "print",
                            className: "btn-sm"
                        },
                    ],
                    responsive: true
                });
            }
        };

        TableManageButtons = function () {
            "use strict";
            return {
                init: function () {
                    handleDataTableButtons();
                }
            };
        }();

        $('#datatable').dataTable({
            'order': [[1, 'asc']],
            'columnDefs': [
                {orderable: false, targets: [2,3]}
            ],
            'iDisplayLength': 10,
        });

        $('#datatable-keytable').DataTable({
            keys: true
        });

        $('#datatable-responsive').DataTable();

        $('#datatable-scroller').DataTable({
            ajax: "js/datatables/json/scroller-demo.json",
            deferRender: true,
            scrollY: 380,
            scrollCollapse: true,
            scroller: true
        });

        $('#datatable-fixed-header').DataTable({
            fixedHeader: true
        });

        var $datatable = $('#datatable-checkbox');

        $datatable.dataTable({
            'order': [[1, 'asc']],
            'columnDefs': [
                {orderable: false, targets: [0]}
            ]
        });
        
        $datatable.on('draw.dt', function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_flat-green'
            });
        });

        TableManageButtons.init();
    });
</script>
<!-- Parsley -->
<script>
                                var metrics = document.getElementsByName("metric");
                                for (var i = 0; i < metrics.length; i++)
                                    metrics[i].addEventListener("click", function () {
                                        document.getElementById("newPred").style.visibility = "visible";
                                    }, true);
                                $(document).ready(function () {
                                    $.listen('parsley:field:validate', function () {
                                        validateFront();
                                    });
                                    $('#demo-form2 .btn-success').on('click', function () {
                                        $('#demo-form2').parsley().validate();
                                        validateFront();
                                    });
                                    var validateFront = function () {
                                        if (true === $('#demo-form2').parsley().isValid()) {
                                            $('.bs-callout-info').removeClass('hidden');
                                            $('.bs-callout-warning').addClass('hidden');
                                        } else {
                                            $('.bs-callout-info').addClass('hidden');
                                            $('.bs-callout-warning').removeClass('hidden');
                                        }
                                    };
                                    $('#heard').on('change', function () {
                                        document.getElementById("newPred").style.visibility = "visible";
                                    });
                                });
                                try {
                                    hljs.initHighlightingOnLoad();
                                } catch (err) {
                                }
                                $(document).ready(function () {
                                    var model1 = "CK Metrics, Scattering - Naive Bayes";
                                    var accuracy = "<%= ac%>";
                                    var precision = "<%= pr%>";
                                    var recall = "<%= re%>";
                                    var fmeasure = "<%= fm%>";
                                    var areaUnderROC = "<%= aur%>";
                                    Morris.Bar({
                                        element: 'graphx',
                                        data: [
                                            {x: 'Accuracy', y: accuracy},
                                            {x: 'Precision', y: precision},
                                            {x: 'Recall', y: recall},
                                            {x: 'Fmeasure', y: fmeasure},
                                            {x: 'AreaUnderROC', y: areaUnderROC}
                                        ],
                                        xkey: 'x',
                                        ykeys: ['y'],
                                        barColors: ['#26B99A', '#34495E', '#ACADAC', '#3498DB'],
                                        hideHover: 'auto',
                                        labels: [[model1]],
                                        resize: true,
                                    }).on('click', function (i, row) {
                                        console.log(i, row);
                                    });
                                })
</script>
<!-- /Parsley -->
