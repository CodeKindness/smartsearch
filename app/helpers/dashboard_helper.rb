module DashboardHelper
  def company_activity_progress(company)
    case
    when company.activity >= 57
      return 'success'
    when company.activity >= 28
      return 'warning'
    else
      return 'danger'
    end
  end

  def progress_hash(company_progresses)
    result = { pending: [], message: [], event: [], offer: [] }
    EventType.order(:order).map(&:name).push('Message', 'Pending').each do |event_type|
      company_progresses.each do |progress|
        next if combine_progress_hash(result).include?(progress)
        result[map_progress_hash_attribute(progress.event_type)] << progress if event_type == progress.event_type
      end
    end
    result
  end

  def progress_images(progress_companies)
    result = ''
    progress_companies.each do |company|
      result += link_to gravatar_image_tag('smartsearch@smartsearch.com', :alt => 'Company gravatar', :gravatar => { :size => 40 }), company_path(company.slug), 'data-toggle': 'tooltip', 'data-placement': 'left', title: company.name
    end
    result
  end

  def progress_panels(progress_companies)
    result = ''
    progress_companies.each do |company|
      result += "<div class='panel panel-default'><div class='panel-body'>#{company.name}</div></div>"
      # result += link_to gravatar_image_tag('smartsearch@smartsearch.com', :alt => 'Company gravatar', :gravatar => { :size => 40 }), company_path(company.id), 'data-toggle': 'tooltip', 'data-placement': 'left', title: company.name
    end
    result
  end

  def map_progress_hash_attribute(event_type)
    case event_type
    when 'Offer Letter'
      return :offer
    when 'Message'
      return :message
    when 'Pending'
      return :pending
    else
      return :event
    end
  end

  def combine_progress_hash(progresses)
    result = []
    progresses.keys.each do |arr|
      result << progresses[arr]
    end
    result.flatten
  end
end
