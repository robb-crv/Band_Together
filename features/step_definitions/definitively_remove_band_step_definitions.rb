And /^it should not exists band called "Band di Rossi" anymore$/ do
 bandRossi = Band.where(name: "Band di Rossi")
 expect(bandRossi.empty?).to eq(true)


end

When /^I press "Delete Band"$/ do
  click_on "Delete Band"
end
