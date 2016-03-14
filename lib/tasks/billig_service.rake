task billig_mock_service: :environment do |t|
  BilligService.run!
end
