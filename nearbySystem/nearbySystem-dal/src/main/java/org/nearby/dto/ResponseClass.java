package org.nearby.dto;

public class ResponseClass {
	  private boolean error;
      private int code;
      private String message;
      private String photo_url;

      public boolean isError() {
          return error;
      }

      public void setError(boolean error) {
          this.error = error;
      }

      public int getCode() {
          return code;
      }

      public void setCode(int code) {
          this.code = code;
      }

      public String getMessage() {
          return message;
      }

      public void setMessage(String message) {
          this.message = message;
      }

      public String getPhoto_url() {
          return photo_url;
      }

      public void setPhoto_url(String photo_url) {
          this.photo_url = photo_url;
      }
}
