/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */

package org.br.cmp.infomail;

/**
 *
 * @author Clayton
 */
public class InfoMail {

    public static void main(String[] args) {
       String from = args[0].replaceAll("\"", "");
       String password = args[1].replaceAll("\"", "");
       String host = args[2].replaceAll("\"", "");
       String port = args[3].replaceAll("\"", "");
       String toEmail = args[4].replaceAll("\"", "");
       String subject = args[5].replaceAll("\"", "");
       String body = args[6].replaceAll("\"", "");
       String filePathAttach = args[7].replaceAll("\"", "");
       
//       String separator = "|-";
//       
//       String[] subjecV = subject.split(separator);
//       subject = "";
//       for (int i = 0; i < subjecV.length - 1; i++) {
//           if(i > 0){
//               subject += " ";
//           }
//            subject += subjecV[i];
//        }
//       
//       String[] bodyV = body.split(separator);
//       body = "";
//       for (int i = 0; i < bodyV.length - 1; i++) {
//           if(i > 0){
//               body += " ";
//           }
//            body += bodyV[i];
//        }
//       
//       String[] filePathAttachV = filePathAttach.split(separator);
//       filePathAttach = "";
//       for (int i = 0; i < filePathAttachV.length - 1; i++) {
//           if(i > 0){
//               filePathAttach += " ";
//           }
//            filePathAttach += filePathAttachV[i];
//        }
       
        SendFileEmail email = new SendFileEmail(from, password, host, port);
        
        email.send(toEmail, subject, body, filePathAttach);
    }
}
