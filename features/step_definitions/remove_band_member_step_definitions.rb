When /^I press on the "X" button near the member "Giulio Bianchi"$/ do
	(find(:css, "#pnlBandMembers ol li", :text => "giuliobianchi")).find(:css, ".btn-danger").click
end

  	