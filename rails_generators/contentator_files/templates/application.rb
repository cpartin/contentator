function getPcbInputs() {
  $$("input.position_text_box").each(function (position) {
    $("sort_form").innerHTML += "<input style=\"display:none;visibility:hidden;\" value=\""+position.value+"\" name=\""+position.name+"\"/>";
  });
}