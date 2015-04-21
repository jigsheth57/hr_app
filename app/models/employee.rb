class Employee < ActiveRecord::Base
    after_create {|employee| employee.message 'Created'}
    after_update {|employee| employee.message 'Updated'}
    after_destroy {|employee| employee.message 'Destroyed'}
    
    def as_json(options={})
        {
            "id" => self.id,
            "name" => self.name,
            "hiredate" => "#{self.hiredate}",
            "salary" => self.salary,
            "fulltime" => self.fulltime,
            "vacationdays" => self.vacationdays,
            "comments" => self.comments,
            "created_at" => "#{self.created_at}",
            "updated_at" => "#{self.updated_at}"
        }
    end
    
    def message action
        msg = "#{action}: #{self.as_json}"
        $exch.publish(msg, :routing_key => $dyn_queue.name)
    end
end
