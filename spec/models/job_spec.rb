require 'rails_helper'

describe Job, '#available_jobs_in_same_group' do
  it 'should only list available jobs in same group' do
    group1 = create(:group)
    group2 = create(:group)
    admission = create(:admission)
    job1 = create(:job, group: group1, admission: admission)
    job2 = create(:job, group: group1, admission: admission)
    job3 = create(:job, group: group2, admission: admission)

    expect(job1.available_jobs_in_same_group).to match_array([job2])
  end
end

describe Job, '#similar_available_jobs' do
  it 'should list similar available jobs' do
    admission = create(:admission)
    job1 = create(:job, admission: admission)
    job2 = create(:job, admission: admission)
    job3 = create(:job, admission: admission)
    job4 = create(:job, admission: admission)

    job1.tag_titles = 'tag1, tag2, tag3, tag4'
    job2.tag_titles = 'tag2, tag3'
    job3.tag_titles = 'tag3, tag1'
    job4.tag_titles = 'something, somethingelse'

    expect(job1.similar_available_jobs).to match_array([job2, job3])
  end
end

describe Job, '#tag_titles=' do
  it 'should create new tags from string input' do
    job = create(:job)
    job.tag_titles = 'one two three four'

    expect(job.tags.pluck(:title)).to match_array(['one', 'two', 'three', 'four'])
  end
end


