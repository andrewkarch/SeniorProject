function SetupFilter(textboxID, gridID, columnName) {
    $('#' + textboxID).keyup(function () {
        var index;
        var text = $("#" + textboxID).val();

        $('#' + gridID + ' tbody tr').each(function () {
            $(this).children('th').each(function () {
                if ($(this).html() == columnName)
                    index = $(this).index();
            });

            $(this).children('td').each(function () {
                if ($(this).index() == index) {
                    var tdText = $(this).children(0).html() == null ? $(this).html() : $(this).children(0).html();

                    if (tdText.indexOf(text, 0) > -1) {
                        $(this).closest('tr').show();
                    } else {
                        $(this).closest('tr').hide();
                    }
                };
            });
        });
    });
};