// Add and remove for proforma
$(document).ready(function(e){

    // Add new element
    $("#add_proforma").on('click', function(e){
     e.preventDefault();
     // Finding total number of elements added
     var total_element = $(".element").length;



     // last <div> with element class id
     var lastid = $(".element:last").attr("id");
     var split_id = lastid.split("_");
     var nextindex = Number(split_id[1]) + 1;

     var max = 10;
     // Check total number elements
     if(total_element < max ){
      // Adding new div container after last occurance of element class
      $(".element:last").after("<div class='element' id='div_"+ nextindex +"'></div>");

      // Adding element to <div>
      $("#div_" + nextindex).append("<div class='row'><div class='col-12'><label for='yourUsername' class='form-label'>File Title_" + nextindex + "</label><div class='input-group has-validation'><span class='input-group-text' id='inputGroupPrepend'><i class='bi bi-upc-scan'></i></span><input name = 'name[]' placeholder='Enter File Title' class='form-control' required><div class='invalid-feedback'>Please enter a valid Email adddress!</div></div></div><div class='col-6'><label for='yourUsername' class='form-label'>File_" + nextindex + "</label><div class='input-group has-validation'><span class='input-group-text' id='inputGroupPrepend'><i class='bi bi-speedometer2'></i></span><input name = 'photo_url[]' placeholder='choose file' class='form-control' required><div class='invalid-feedback'>Please enter a valid Email adddress!</div></div></div></div><div class='col-md-1'><span id='remove_" + nextindex + "' class='remove bi bi-x-circle' style='font-size: 18px;color:red !important'></span></div>");
     }

    });


     // Remove element
     $('.containers').on('click','.remove',function(){

      var id = this.id;
      var split_id = id.split("_");
      var deleteindex = split_id[1];

      console.log(deleteindex);

      // Remove <div> with id
      $("#div_" + deleteindex).remove();

     });
    });