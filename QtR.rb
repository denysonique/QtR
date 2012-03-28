require 'rubygems'
require 'Qt4'

module Qt
  extend Qt

  class PushButton #todo override all methods which use set_enabled/disabled
    def enable
      set_enabled true
    end
    def disable
      set_disabled true
    end
  end
  
  class Menu
    def <<(item)
      if item[0].is_a? Action
        action = item
      else
        action = Action.new self
        action.set_text item[0]
      end

      if defined? item[1]
        action.connect(SIGNAL :triggered) { item[1].call }
      end
        
      add_action(action)
    end
  end
  
  class Label
    #alias :text= :set_text 
    def text=(arg)
      set_text(arg)
    end

  end

  class TreeWidget
    alias :qt_connect :connect

    def << item
      addTopLevelItem(item)
    end

    def connect(slot, &block)
      if slot == :item_clicked
        qt_connect(SIGNAL( 'itemClicked(QTreeWidgetItem *, int)'), &block)
      end
    end
  end
end
