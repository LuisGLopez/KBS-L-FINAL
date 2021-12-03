/**
 * ***************************************************************
 * JADE - Java Agent DEvelopment Framework is a framework to develop
 * multi-agent systems in compliance with the FIPA specifications.
 * Copyright (C) 2000 CSELT S.p.A.
 * 
 * GNU Lesser General Public License
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation,
 * version 2.1 of the License.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA  02111-1307, USA.
 * **************************************************************
 */
package examples.protocols;

import jade.core.Agent;
import jade.lang.acl.ACLMessage;
import jade.lang.acl.MessageTemplate;
import jade.proto.ContractNetResponder;
import jade.domain.FIPANames;
import jade.domain.FIPAAgentManagement.NotUnderstoodException;
import jade.domain.FIPAAgentManagement.RefuseException;
import jade.domain.FIPAAgentManagement.FailureException;

import net.sf.clipsrules.jni.*;

/**
   This example shows how to implement the responder role in 
   a FIPA-contract-net interaction protocol. In this case in particular 
   we use a <code>ContractNetResponder</code>  
   to participate into a negotiation where an initiator needs to assign
   a task to an agent among a set of candidates.
   @author Giovanni Caire - TILAB
 */
public class ContractNetResponderAgent extends Agent {
	Environment clips;

	protected void setup() {
		
		Object[] args = getArguments();
		// amazonphone, amazonpc, alibaba
		
		try{
			clips = new Environment();
			clips.build("(deftemplate smartphone(slot brand)(slot model)(slot color)(slot price))");
			switch (args[0].toString()) {
			case "phone":
				clips.load("C:\\Users\\destr\\Documents\\7mo Semestre\\KBS\\KBS-L repo\\HandsOn5\\Jade\\src\\clips\\templates-amz-phone.clp");
				break;
			case "pc":
				clips.load("C:\\Users\\destr\\Documents\\7mo Semestre\\KBS\\KBS-L repo\\HandsOn5\\Jade\\src\\clips\\tempaltes-amz-pc.clp");
				break;
			case "ali":
				clips.load("C:\\Users\\destr\\Documents\\7mo Semestre\\KBS\\KBS-L repo\\HandsOn5\\Jade\\src\\clips\\templates.clp");
				break;
			}
		}catch(Exception e){
			System.out.println("Error: " + e.getMessage());
		}
		System.out.println("Agent "+getLocalName()+" waiting for CFP...");
		MessageTemplate template = MessageTemplate.and(
				MessageTemplate.MatchProtocol(FIPANames.InteractionProtocol.FIPA_CONTRACT_NET),
				MessageTemplate.MatchPerformative(ACLMessage.CFP) );

		addBehaviour(new ContractNetResponder(this, template) {
			// Add in handlecfp method the code to run the facts received from the initiator
			@Override
			protected ACLMessage handleCfp(ACLMessage cfp) throws NotUnderstoodException, RefuseException {
				System.out.println("Agent "+getLocalName()+": CFP received from "+cfp.getSender().getName()+". Action is "+cfp.getContent());
				// handle the facts received from the initiator
				try{
					clips.eval("(rules)");
					clips.eval(cfp.getContent().toString());
					long result = clips.run();
					System.out.println("Agent "+getLocalName()+": Execute "+result + " rules");
					if(result > 0){
						System.out.println("Agent "+getLocalName()+": Rules fired");
						ACLMessage reply = cfp.createReply();
						reply.setPerformative(ACLMessage.PROPOSE);
						reply.setContent(String.valueOf(result));
						return reply;
					}
					else{
						System.out.println("Agent "+getLocalName()+": Rules not fired");
						throw new RefuseException("Rules not fired");
					}
				}
				catch(CLIPSException e){
					System.out.println("Error: " + e.getMessage());
					return null;
				}
			}

			@Override
			protected ACLMessage handleAcceptProposal(ACLMessage cfp, ACLMessage propose,ACLMessage accept) throws FailureException {
				System.out.println("Agent "+getLocalName()+": Proposal accepted");
				
				System.out.println("Agent "+getLocalName()+" successfully sold the product.");
				ACLMessage inform = accept.createReply();
				inform.setPerformative(ACLMessage.INFORM);
				return inform;
			}

			protected void handleRejectProposal(ACLMessage cfp, ACLMessage propose, ACLMessage reject) {
				System.out.println("Agent "+getLocalName()+": Proposal rejected");
			}
		} );
	}

	private int evaluateAction() {
		// Simulate an evaluation by generating a random number
		return (int) (Math.random() * 10);
	}

	private boolean performAction() {
		// Simulate action execution by generating a random number
		return (Math.random() > 0.2);
	}
}

