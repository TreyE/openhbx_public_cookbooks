require_recipe "openhbx_access::default"

openhbx_access_user "matt.williams" do
  other_groups ["sysops", "sshusers"]
  ssh_keys({
    "mattwilliams@Matts-MacBook-Pro.local" => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUGs9twKr/MWP5SkzkafCG0TBCAq1SBb6Ka+BwiJCW0XRgEVVgrU0KJL4tELJQthidpobHP89ViSnizgqlATg5oaCaoKomNj8sfEQSuPfWCaP1xwh0jTMwGeCYIi3fRc0Pi7FBrjQgSwGS0IvquvJEXTra1Lp41OWxNqvMOXImODW2hns37VJiywvPCXT1Gvrk5As/usWxO1y81xf1/qmEMnuDxD4Mjzx4R78k9AvzOdv6+/4tumw+e3cg2o3LHM5t684Un+7MkKm9W2WKvbYAnVPaIX2wEEim9ZfG0JJjRyiN6GvM1Cjx//3MAB1S6pHzpKxV6GcFluPKkvIF4nR/"
  })
end
