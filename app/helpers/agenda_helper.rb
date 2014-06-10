module AgendaHelper


  def inschrijvingen_panel_type(agendaitem, subscription)
    if !agendaitem.deadline_passed?
      if defined?(subscription)
        data='panel-success'
      else
        data='panel-primary'
      end
    else 
      data='panel-default'
    end
  end


end
