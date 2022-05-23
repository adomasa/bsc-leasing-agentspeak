package c4j;
import javax.swing.*;
import java.awt.event.*;
import cartago.*;
import cartago.tools.*;

public class MySimpleGUI extends GUIArtifact {

	private LoginFrame loginFrame;
	private ControlCodeFrame controlCodeFrame;
	private ApplicationFrame applicationFrame;
	
	public void setup() {
		loginFrame = new LoginFrame();
		controlCodeFrame = new ControlCodeFrame();
		applicationFrame = new ApplicationFrame();

		linkActionEventToOp(loginFrame.autentifikavimoMygtukas, "patvirtintiTapatybe");
		linkActionEventToOp(applicationFrame.paraiskosPateikimoMygtukas, "pateiktiParaiska");
		linkWindowClosingEventToOp(loginFrame, "terminuoti");

		loginFrame.setVisible(true);	
		controlCodeFrame.setVisible(false);
		applicationFrame.setVisible(false);
	}

	@INTERNAL_OPERATION void terminuoti(WindowEvent ev){
		signal("terminuoti_agenta");
	}

	@INTERNAL_OPERATION void patvirtintiTapatybe(WindowEvent ev){
		signal("patvirtinti_tapatybe", loginFrame.asmensKodas);
	}

	@INTERNAL_OPERATION void pateiktiParaiska(WindowEvent ev){
		signal("pateikti_paraiska",
			loginFrame.asmensKodas,
			applicationFrame.pajamos,
			applicationFrame.isipareigojimai,
			applicationFrame.isiskolinimoSuma,
			applicationFrame.isankstinisMokejimas,
			applicationFrame.prekesVerte,
			applicationFrame.isiskolinimoPeriodas
		);
	}

	@OPERATION void atidarytiParaiskosIvertinimoLanga(int sprendimas){
		String decisionText = sprendimas == 1 ? "Jūsų paraiška buvo priimta" : "Jūsų paraiška buvo atmesta";
		Alert alert = new Alert(Alert.AlertType.NONE, decisionText, ButtonType.OK);
	}

	@OPERATION void atnaujintiKontroliniKoda(int value){
		loginFrame.setVisible(false);
		controlCodeFrame.setVisible(true);
		applicationFrame.setVisible(false);

		controlCodeFrame.setControlCode(""+value);
	}

	@OPERATION void atidarytiParaiskosLanga(){
		loginFrame.setVisible(false);
		controlCodeFrame.setVisible(false);
		applicationFrame.setVisible(true);
	}

	private int getValue(){
		return Integer.parseInt(loginFrame.getText());
	}
	
	class LoginFrame extends JFrame {		
		
		private JButton autentifikavimoMygtukas;
		private JTextField asmensKodas;
		
		public LoginFrame(){
			setTitle("Demonstracinė lizingavimo sistema");
			setSize(330,450);
			
			JPanel panel = new JPanel();
			setContentPane(panel);
			
			autentifikavimoMygtukas = new JButton("Patvirtinti tapatybę");
			autentifikavimoMygtukas.setSize(80,50);
			
			asmensKodas = new JTextField(10);
			asmensKodas.setText("0");
			asmensKodas.setEditable(true);
			
			
			panel.add(asmensKodas);
			panel.add(autentifikavimoMygtukas);
			
		}
		
		public String getText(){
			return asmensKodas.getText();
		}

		public void setText(String s){
			asmensKodas.setText(s);
		}
	}

	class ControlCodeFrame extends JFrame {		
		private JButton cancelButton;
		private JTextField controlCodeText;
		
		public ControlCodeFrame(){
			setTitle("Demonstracinė lizingavimo sistema");
			setSize(330,450);
			
			JPanel panel = new JPanel();
			setContentPane(panel);
			
			cancelButton = new JButton("Atšaukti");
			cancelButton.setSize(80,50);
			
			controlCodeText = new JTextField(1);
			controlCodeText.setText("----");
			controlCodeText.setEditable(false);
			
			
			panel.add(controlCodeText);
			panel.add(cancelButton);
		}

		public void setControlCode(String code){
			controlCodeText.setText(code);
		}
	}

	class ApplicationFrame extends JFrame {		
		private JButton paraiskosPateikimoMygtukas;
		private JTextField pajamos;
		private JTextField isipareigojimai;
		private JTextField isiskolinimoSuma;
		private JTextField isiskolinimoPeriodas;
		private JTextField isankstinisMokejimas;
		private JTextField prekesVerte;
		
		public ApplicationFrame(){
			setTitle("Demonstracinė lizingavimo sistema");
			setSize(480,640);
			
			JPanel panel = new JPanel();
			setContentPane(panel);
			
			paraiskosPateikimoMygtukas = new JButton("Pateikti paraišką");
			paraiskosPateikimoMygtukas.setSize(400,70);
			
			pajamos = new JTextField(1);
			pajamos.setText("");
			pajamos.setEditable(true);

			isipareigojimai = new JTextField(1);
			isipareigojimai.setText("");
			isipareigojimai.setEditable(true);

			isiskolinimoSuma = new JTextField(1);
			isiskolinimoSuma.setText("");
			isiskolinimoSuma.setEditable(true);

			isiskolinimoPeriodas = new JTextField(1);
			isiskolinimoPeriodas.setText("");
			isiskolinimoPeriodas.setEditable(true);
			
			isankstinisMokejimas = new JTextField(1);
			isankstinisMokejimas.setText("");
			isankstinisMokejimas.setEditable(true);

			prekesVerte = new JTextField(1);
			prekesVerte.setText("");
			prekesVerte.setEditable(true);
			
			
			panel.add(pajamos);
			panel.add(isipareigojimai);
			panel.add(isiskolinimoSuma);
			panel.add(isiskolinimoPeriodas);
			panel.add(isankstinisMokejimas);
			panel.add(prekesVerte);
			panel.add(paraiskosPateikimoMygtukas);
		}
	}


}
