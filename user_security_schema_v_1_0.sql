CREATE TABLE permissions (
  id int(11) NOT NULL,
  permission_name varchar(50) NOT NULL,
  description varchar(250) DEFAULT NULL,
  created_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  created_by varchar(36),
  modified_ts timestamp,
  modified_by varchar(36),
  PRIMARY KEY (id),
  UNIQUE KEY permission_name_UNIQUE (permission_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='permission / action allowed or disable example OP_READ_ACCOUNT, OP_DELETE_ACCOUNT etc';


CREATE TABLE persistent_logins (
   id varchar(36) NOT NULL,
   series varchar(64) NOT NULL,
   user_id varchar(36) NOT NULL,
   token varchar(512) NOT NULL,
   last_used timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   created_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   created_by varchar(36),
   modified_ts timestamp,
   modified_by varchar(36),
  PRIMARY KEY (id),
  KEY fk_persistent_logins_userid_idx (user_id),
  CONSTRAINT fk_persistent_logins_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE role_permissions (
   id bigint(10) NOT NULL AUTO_INCREMENT,
   role_id int(11) NOT NULL,
   permission_id int(11) NOT NULL,
   created_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   created_by varchar(36),
   modified_ts timestamp,
   modified_by varchar(36),
  PRIMARY KEY (id),
  KEY fk_role_perm_role_id_idx (role_id),
  KEY fk_role_perm_perm_id_idx (permission_id),
  CONSTRAINT fk_role_perm_perm_id FOREIGN KEY (permission_id) REFERENCES permissions (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_role_perm_role_id FOREIGN KEY (role_id) REFERENCES roles` (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE roles (
   id int(11) NOT NULL,
   rolename varchar(50) NOT NULL,
   description varchar(250) DEFAULT NULL,
   created_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   created_by varchar(36),
   modified_ts timestamp,
   modified_by varchar(36),
  PRIMARY KEY (id),
  UNIQUE KEY rolename_UNIQUE (rolename)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='user roles , generally authorities associated with user described in spring example ROLE_USER, ROLE_ADMIN authority';

CREATE TABLE user_roles (
   id bigint(10) NOT NULL,
   user_id varchar(36) NOT NULL,
   role_id int(11) NOT NULL,
   created_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   created_by varchar(36),
   modified_ts timestamp,
   modified_by varchar(36),
  PRIMARY KEY (id),
  KEY fk_user_role_userid_idx (user_id),
  KEY fk_user_role_role_id_idx (role_id),
  CONSTRAINT fk_user_role_role_id FOREIGN KEY (role_id) REFERENCES roles (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_user_role_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='user associated roles';

CREATE TABLE users (
   id varchar(36),
   username varchar(256) NOT NULL,
   password varchar(100) NOT NULL,
   password_encrypted tinyint(4) NOT NULL DEFAULT '0',
   enabled tinyint(4) NOT NULL DEFAULT '0',
   created_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   created_by varchar(36),
   modified_ts timestamp,
   modified_by varchar(36),
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE client_info (
   id varchar(36),
   user_id varchar(36) NOT NULL,
   secret_key varchar(512) NOT NULL,
   secret_key_encrypted tinyint(4) NOT NULL DEFAULT '0',
   enabled tinyint(4) NOT NULL DEFAULT '0',
   created_ts timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
   created_by varchar(36),
   modified_ts timestamp,
   modified_by varchar(36),
  PRIMARY KEY (id),
  KEY fk_client_info_userid_idx (user_id),
  CONSTRAINT fk_client_info_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
