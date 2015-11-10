$(document).ready(function(){

	var noticia = $('#notice');
	var alerta = $('#alert');

	if (!$(notice).text()  == "") {
		$("#notice").animate({
			top: "10%"});
		$('#notice').delay(4000).fadeOut(2000);
	};

	var objeto = $('.jumbotron .objeto');

	$(objeto).click(function() {
		var popover = $(this).children("div");
		$(popover).slideToggle(400);
	});

	var popover = $(objeto).children("div");
	
		$(popover).mouseleave(function() {
			$(this).slideUp(400);
			});


	/*validar nit*/
	function nitIsValid(nit) {
    if (!nit) {
        return true;
    }

    var nitRegExp = new RegExp('^[0-9]+(-?[0-9kK])?$');

    if (!nitRegExp.test(nit)) {
        return false;
    }

    nit = nit.replace(/-/, '');
    var lastChar = nit.length - 1;
    var number = nit.substring(0, lastChar);
    var expectedCheker = nit.substring(lastChar, lastChar + 1).toLowerCase();

    var factor = number.length + 1;
    var total = 0;

    for (var i = 0; i < number.length; i++) {
        var character = number.substring(i, i + 1);
        var digit = parseInt(character, 10);

        total += (digit * factor);
        factor = factor - 1;
    }

    var modulus = (11 - (total % 11)) % 11;
    var computedChecker = (modulus == 10 ? "k" : modulus.toString());

    return expectedCheker === computedChecker;
}

$('#contribuyente_nit').bind('change paste keyup', function (e) {
    var $this = $(this);
    var $parent = $this.parent();
    var $prev = $this.prev();
    var $guardar = $('.actions #guardar');
    var nit = $this.val();

    if (nit && nitIsValid(nit)) {
        $parent.addClass('has-success');
        $prev.addClass('fa-check');
        $parent.removeClass('has-error');
        $prev.removeClass('fa-exclamation-circle');
        $guardar.removeClass('disabled');
    } else if (nit) {
        $parent.addClass('has-error');
        $prev.addClass('fa-exclamation-circle');
        $parent.removeClass('has-success');
        $prev.removeClass('fa-check');
        $guardar.addClass('disabled');
    } else {
        $parent.removeClass('has-error');
        $prev.removeClass('fa-exclamation-circle');
        $parent.removeClass('has-success');
        $prev.removeClass('fa-check');
        $guardar.addClass('disabled');

    }
});

})