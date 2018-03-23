CREATE TABLE roles (
  id INT NOT NULL,
  rolename VARCHAR(50) NOT NULL,
  description VARCHAR(250) NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX rolename_UNIQUE (rolename ASC))
COMMENT = 'user roles , generally authorities associated with user described in spring example ROLE_USER, ROLE_ADMIN authority';

CREATE TABLE permissions (
  id INT NOT NULL,
  permission_name VARCHAR(50) NOT NULL,
  description VARCHAR(250) NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX permission_name_UNIQUE (permission_name ASC))
COMMENT = 'permission / action allowed or disable example OP_READ_ACCOUNT, OP_DELETE_ACCOUNT etc';

CREATE TABLE role_permissions (
  id BIGINT(10) NOT NULL AUTO_INCREMENT,
  role_id INT NOT NULL,
  permission_id INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX fk_role_perm_role_id_idx (`role_id` ASC),
  INDEX fk_role_perm_perm_id_idx (`permission_id` ASC),
  CONSTRAINT fk_role_perm_role_id
    FOREIGN KEY (role_id)
    REFERENCES roles (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_role_perm_perm_id
    FOREIGN KEY (permission_id)
    REFERENCES permissions (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

	
CREATE TABLE user_roles(
	id BIGINT(10) NOT NULL,
	username VARCHAR(256) NOT NULL,
	role_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_user_role_username_idx (username ASC),
  INDEX fk_user_role_role_id_idx (role_id ASC),
  CONSTRAINT fk_user_role_username
    FOREIGN KEY (username)
    REFERENCES users (username)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_user_role_role_id
    FOREIGN KEY (role_id)
    REFERENCES roles (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
COMMENT = 'user associated roles';
