namespace :db do
  desc "TODO"
  task :anonymize_admissions => :environment do
    Applicant.where("phone != ?", "12345678").each do |applicant|
      password = Faker::Internet.password
      applicant.assign_attributes(
        firstname: Faker::Name.first_name,
        surname: Faker::Name.last_name,
        phone: "12345678",
        email: Faker::Internet.email,
        password: password,
        password_confirmation: password
      )
      applicant.save(validate: false)
    end

    Interview.where("comment != ?", "").each do |interview|
      interview.assign_attributes(comment: "")
      interview.save(validate: false)
    end

    JobApplication.where("motivation != ?", "").each do |job_application|
      job_application.assign_attributes(motivation: "")
      job_application.save(validate: false)
    end
  end
end
