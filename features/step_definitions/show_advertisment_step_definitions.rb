



  When /^I follow the link to "Cercasi chitarrista"$/ do
    find(:css,"#pnlActiveAdvertisments ol li a", :text => "Cercasi chitarrista").click
  end
