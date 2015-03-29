module RotiAmount
  def load
    amounts.each do |amount|
      proxy_association.target << amount
    end
  end

  private

  def amounts
    return_array = []
    through_collection.each_with_index do |through, i|
      associate = through.send(reflection_name)
      associate.assign_attributes({amount: items[i]}) if items[i].present?
      return_array.concat Array.new(1).fill(associate)
    end
    return_array
  end
end
