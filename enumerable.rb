#TODO: add enumerator conversion to my_each

module Enumerable
  def my_each
    for i in self
      yield(i)  
    end
  end

  def my_each_with_index
    for i in self
      index = 0	
      yield(i, index+=1)
    end
  end

  def my_map(&block)
  	out = []
  	self.my_each {|x| out << block.call(x)}
  	out
  end

  def my_select 
    out = []
    self.my_each {|x| out << x if yield(x)}
    out
  end

  def my_all?
  	count = 0
    self.my_each {|x| count+=1 if yield(x)}
    count == self.size
  end

  def my_any?
  	count = 0
    self.my_each {|x| count+=1 if yield(x)}
    count > 0
  end

  def my_none?
  	count = 0
    self.my_each {|x| count+=1 if yield(x)}
    count == 0
  end

  def my_count(num=nil)
    count = 0
    if block_given? && num.nil?
      self.my_each {|x| count+=1 if yield(x)}
    else
      self.my_each {|x| count+=1 if x == num}
    end
    count
  end

  def my_inject(*n)
    n.empty? ? n = self.first : n = n[0] 
    self.my_each {|x| n = yield(n,x)}
    n
  end 
end


#test it out:

  ["what","a","cool","module"].my_each {|x| x}
  ["what","a","cool","module"].my_each_with_index {|x,i| p [x,i]}
  ["what","a","cool","module"].my_each_with_index {|x,i| p [x,i]}
  ["what","a","cool","module"].my_map {|x| "Captain Picard"}
  ["what",1232,"cool","module"].my_select {|x| x.is_a?(String)}
  ["what",1232,"cool","module"].my_all? {|x| x.is_a?(String)}
  ["what",1232,"cool","module"].my_any? {|x| x.is_a?(String)}
  ["what",1232,"cool","module"].my_none? {|x| x.is_a?(String)}
  ["what",1232,"cool","module","dude"].my_count {|x| x.is_a?(String)}
  ["what",1232,"cool","module","dude"].my_count("cool") {|x| x.is_a?(String)}
  [2,3,4,5,6,7,8,9].my_inject() {|sum,x| sum * x}
  [2,3,4,5,6,7,8,9].my_inject([]) {|result,element| result << element if element.even?; result}
  
  proc = ->(x) { "change is good"}
  ["what",1232,"cool","module","dude"].my_map(&proc)


  