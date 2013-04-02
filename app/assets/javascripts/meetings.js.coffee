# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

<script src="jquery.js"></script>
<script src="bootstrap.js"></script>
<script src="bootstrap-overflow-navs.js"></script>
<script>
    $("#menu").overflowNavs({
        "more" : "More", 
        "parent" : ".nav-collapse",
        "override_width" : true
    });
</script>