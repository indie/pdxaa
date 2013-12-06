jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip();


TrCollapse ->
  $("#table").overflowTr({
        "more" : "More", 
        "parent" : ".tr-collapse",
        "override_width" : true
    });

