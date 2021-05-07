require 'byebug'
class PolyTreeNode
    attr_reader :parent, :children, :value
    def initialize(value)
        @value = value
        @parent = nil  # node instance 
        @children = []
    end

    def parent=(node)  # self.parent = node 
        parent.children.delete_at(parent.children.index(self)) if parent != nil #&& parent.parent == nil
        @parent = node
        node.children << self if node != nil#&& !node.children.include?(self)
    end

    def add_child(node)  #self.add_child(node)
        node.parent = self
    end  

    def remove_child(node) 
        raise 'error' if !self.children.include?(node)
        node.parent = nil
    end 

    def dfs(target)
        return self if self.value == target
        self.children.each{|ele|
            something = ele.dfs(target)
            something.nil? ? nil : (return something)
        }
        nil
    end 

    def bfs(target)
        arr = [self]
        i = 0
        while (i < arr.length)
            ele = arr.shift
            return ele if ele.value == target
            arr += ele.children 
        end 
        nil
        # ele = arr.pop
        # return ele if ele.value == target
        # if arr.length == 0
        # ele.children + arr
    end

end