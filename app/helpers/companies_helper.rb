module CompaniesHelper
  def rating_guide(int = 0)
    int = 0 if int.nil?
    result = []
    int.times.each do
      result << content_tag(:i, '', class: 'fa fa-star')
    end
    (5-int).times.each do
      result << content_tag(:i, '', class: 'fa fa-star-o')
    end
    result.join(' ')
  end

  def contact_companies(contact)
    if contact.companies.any?
      contact.companies.map(&:name).join(', ')
    else
      'NA'
    end
  end
end
