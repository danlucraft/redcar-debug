class Redcar::GDI::OutputController::ReplController
  def initialize(output_controller, process_controller)
    @output_controller = output_controller
    @process_controller = process_controller
    process_controller.add_listener(:process_halted) { show_prompt }
    process_controller.add_listener(:process_resumed) { hide_prompt }
    process_controller.add_listener(:process_finished) { hide_prompt }
    process_controller.add_listener(:stdout_ready) {|out| print(out, "stdout") }
    process_controller.add_listener(:stderr_ready) {|out| print(out, "stderr") }
  end
  
  def execute(*args)
    @output_controller.execute(*args)
  end
  
  def append(text)
    @output_controller.append(text, "repl")
  end
  
  # TODO: Hook up colours
  def process(text)
    text.gsub("\n", "<br>")
  end
  
  def show_prompt
    execute('$("#input").show();$("#input").focus();')
  end

  def hide_prompt
    execute('$("#input").hide();')
  end
  
  def print(out, cssclass)
    append(<<-HTML)
      <span class="#{cssclass}">#{process(out)}</span>
    HTML
  end
end