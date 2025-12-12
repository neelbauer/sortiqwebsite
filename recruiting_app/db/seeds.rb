# Clear existing data
puts "Clearing existing data..."
JobCandidate.destroy_all
CompanyJob.destroy_all
CompanyCandidate.destroy_all
HiringTeamMember.destroy_all
Candidate.destroy_all
Job.destroy_all
Company.destroy_all

puts "Creating clients..."
# Create 5 Clients
clients = [
  {
    company_name: "TechCorp Solutions",
    url: "https://techcorp.com",
    phone_number: "(415) 555-0101",
    description: "Leading enterprise software company specializing in cloud infrastructure and DevOps tools.",
    headcount: 500,
    address_1: "123 Tech Street",
    city: "San Francisco",
    state: "CA",
    zip_code: "94105",
    is_client: true
  },
  {
    company_name: "DataFlow Analytics",
    url: "https://dataflow.io",
    phone_number: "(650) 555-0202",
    description: "Big data analytics platform helping enterprises make data-driven decisions.",
    headcount: 250,
    address_1: "456 Data Avenue",
    city: "Palo Alto",
    state: "CA",
    zip_code: "94301",
    is_client: true
  },
  {
    company_name: "CloudNine Systems",
    url: "https://cloudnine.com",
    phone_number: "(408) 555-0303",
    description: "Cloud-native application development and deployment solutions.",
    headcount: 180,
    address_1: "789 Cloud Boulevard",
    city: "San Jose",
    state: "CA",
    zip_code: "95110",
    is_client: true
  },
  {
    company_name: "SecureNet Technologies",
    url: "https://securenet.com",
    phone_number: "(415) 555-0404",
    description: "Cybersecurity solutions for modern enterprises.",
    headcount: 320,
    address_1: "321 Security Way",
    city: "San Francisco",
    state: "CA",
    zip_code: "94107",
    is_client: true
  },
  {
    company_name: "AI Innovations Lab",
    url: "https://ailab.com",
    phone_number: "(650) 555-0505",
    description: "Machine learning and artificial intelligence research and development.",
    headcount: 150,
    address_1: "654 Innovation Drive",
    city: "Mountain View",
    state: "CA",
    zip_code: "94043",
    is_client: true
  }
]

clients.each do |client_data|
  Company.create!(client_data)
end

puts "Creating client prospects..."
# Create 5 Client Prospects
prospects = [
  {
    company_name: "StartupFlow Inc",
    url: "https://startupflow.com",
    phone_number: "(510) 555-0606",
    description: "Agile project management tools for fast-growing startups.",
    headcount: 45,
    address_1: "111 Startup Lane",
    city: "Oakland",
    state: "CA",
    zip_code: "94612",
    is_client: false
  },
  {
    company_name: "FinTech Dynamics",
    url: "https://fintechdynamics.com",
    phone_number: "(415) 555-0707",
    description: "Financial technology solutions for modern banking.",
    headcount: 120,
    address_1: "222 Finance Street",
    city: "San Francisco",
    state: "CA",
    zip_code: "94111",
    is_client: false
  },
  {
    company_name: "HealthTech Partners",
    url: "https://healthtechpartners.com",
    phone_number: "(650) 555-0808",
    description: "Healthcare technology and telemedicine platforms.",
    headcount: 200,
    address_1: "333 Health Plaza",
    city: "Redwood City",
    state: "CA",
    zip_code: "94063",
    is_client: false
  },
  {
    company_name: "EcoTech Solutions",
    url: "https://ecotech.com",
    phone_number: "(408) 555-0909",
    description: "Sustainable technology and green energy solutions.",
    headcount: 75,
    address_1: "444 Green Way",
    city: "Santa Clara",
    state: "CA",
    zip_code: "95050",
    is_client: false
  },
  {
    company_name: "Gaming Nexus",
    url: "https://gamingnexus.com",
    phone_number: "(415) 555-1010",
    description: "Mobile and console game development studio.",
    headcount: 90,
    address_1: "555 Game Street",
    city: "San Francisco",
    state: "CA",
    zip_code: "94103",
    is_client: false
  }
]

prospects.each do |prospect_data|
  Company.create!(prospect_data)
end

puts "Creating hiring team members..."
# Add hiring team members to companies
Company.all.each do |company|
  2.times do |i|
    company.hiring_team_members.create!(
      name: ["Sarah Johnson", "Mike Chen", "Emily Davis", "James Wilson", "Lisa Anderson"].sample,
      title: ["VP Engineering", "Head of Talent", "Technical Recruiter", "Engineering Manager"].sample,
      email: "contact#{i+1}@#{company.company_name.downcase.gsub(' ', '')}.com",
      phone_number: "(#{rand(200..999)}) 555-#{rand(1000..9999)}",
      linkedin_url: "https://linkedin.com/in/#{company.company_name.downcase.gsub(' ', '-')}-#{i+1}"
    )
  end
end

puts "Creating jobs..."
# Create jobs for each company (1-2 jobs per company)
job_titles = [
  "Senior Software Engineer",
  "Full Stack Developer",
  "DevOps Engineer",
  "Data Engineer",
  "Machine Learning Engineer",
  "Frontend Developer",
  "Backend Developer",
  "Security Engineer",
  "Cloud Architect",
  "Engineering Manager"
]

Company.all.each do |company|
  rand(1..2).times do
    job = Job.create!(
      job_title: job_titles.sample,
      concise_description: "#{job_titles.sample} position at #{company.company_name}",
      job_url: "https://careers.#{company.company_name.downcase.gsub(' ', '')}.com/job-#{rand(1000..9999)}",
      hiring_manager: company.hiring_team_members.first&.name || "Hiring Manager",
      tech_stack: ["React", "Node.js", "Python", "PostgreSQL", "AWS", "Docker", "Kubernetes", "GraphQL"].sample(4).join(", "),
      salary_range_low: [80000, 100000, 120000, 140000].sample,
      salary_range_high: [130000, 150000, 180000, 200000].sample,
      description: "We are looking for a talented engineer to join our growing team. You will work on exciting projects, collaborate with cross-functional teams, and have opportunities for growth and learning.",
      date_opened: rand(1..90).days.ago
    )
    
    # Associate job with company
    CompanyJob.create!(company: company, job: job)
  end
end

puts "Creating candidates..."
# Create candidates
first_names = ["John", "Jane", "Michael", "Sarah", "David", "Emily", "Robert", "Jennifer", "William", "Jessica",
               "Alex", "Maria", "Chris", "Amanda", "Daniel", "Ashley", "Kevin", "Nicole", "Ryan", "Stephanie"]
last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez",
              "Anderson", "Taylor", "Thomas", "Moore", "Jackson", "Martin", "Lee", "Thompson", "White", "Harris"]

40.times do |i|
  candidate = Candidate.create!(
    first_name: first_names.sample,
    last_name: last_names.sample,
    email: "candidate#{i+1}@email.com",
    phone: "(#{rand(200..999)}) 555-#{rand(1000..9999)}",
    grade: ["A+", "A", "B+", "B", "C+"].sample,
    source: ["LinkedIn", "Referral", "Indeed", "Direct Application", "Recruiter"].sample,
    linkedin: "https://linkedin.com/in/candidate-#{i+1}",
    github: "https://github.com/candidate#{i+1}",
    tech_stack: ["JavaScript", "Python", "Ruby", "Java", "Go", "React", "Angular", "Vue.js", "Node.js", "Django"].sample(5).join(", "),
    fun: "Passionate about technology and continuous learning. Enjoys hiking and photography in spare time.",
    resume_text: "Experienced software engineer with #{rand(2..10)} years of experience in full-stack development. Strong background in modern web technologies and agile methodologies."
  )
  
  # Associate candidate with 1-2 random companies
  Company.all.sample(rand(1..2)).each do |company|
    CompanyCandidate.create!(company: company, candidate: candidate)
  end
end

puts "Associating candidates with jobs..."
# Associate candidates with jobs (4 candidates per job)
Job.all.each do |job|
  Candidate.all.sample(4).each do |candidate|
    # Skip if already associated
    unless JobCandidate.exists?(job: job, candidate: candidate)
      JobCandidate.create!(
        job: job,
        candidate: candidate,
        stage: JobCandidate::STAGES.sample
      )
    end
  end
end

puts "Seed data created successfully!"
puts "---"
puts "Summary:"
puts "Clients: #{Company.where(is_client: true).count}"
puts "Client Prospects: #{Company.where(is_client: false).count}"
puts "Jobs: #{Job.count}"
puts "Candidates: #{Candidate.count}"
puts "Hiring Team Members: #{HiringTeamMember.count}"
