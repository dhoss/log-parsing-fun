# expected:
# 172.16.8.48 drops total 34 packets
# 172.16.8.45 drops total 23 packets
# 172.16.8.44 drops total 10 packets
# sorted by IP

class LogStats

  def parse(file)
    drops_by_ip = []
    File.foreach(file) do |line|
      drops_by_ip << (line.split)[2..5]
    end

    return drops_by_ip
  end

  def filter(dataset)
    filtered = []
    dataset.each do |row|
      ips = {}
      if row.include?("drops")
        ips[row[0]] = row[2]
        filtered << ips
      end
    end
    return filtered
  end

  def sort(dataset)
  end

  def aggregate(dataset)
    dataset.inject{|ip, drops| ip.merge(drops){|k, old_v, new_v| old_v.to_i + new_v.to_i}}
  end

  def results(file)
    aggregate(filter(parse(file)))
  end

end

