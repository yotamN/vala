/* formalparameter.vala
 *
 * Copyright (C) 2008  Florian Brosch
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Florian Brosch <flo.brosch@gmail.com>
 */

using Gee;
using Valadoc.Content;

public class Valadoc.Api.FormalParameter : Symbol {
	public FormalParameter (Vala.Parameter symbol, Node parent) {
		base (symbol, parent);
		parameter_type = new TypeReference (symbol.variable_type, this);
	}

	public bool is_out {
		get {
			return ((Vala.Parameter) symbol).direction == Vala.ParameterDirection.OUT;
		}
	}

	public bool is_ref {
		get {
			return ((Vala.Parameter) symbol).direction == Vala.ParameterDirection.REF;
		}
	}

	public bool has_default_value {
		get {
			return ((Vala.Parameter) symbol).initializer != null;
		}
	}

	public TypeReference? parameter_type { private set; get; }

	public bool ellipsis {
		get {
			return ((Vala.Parameter) symbol).ellipsis;
		}
	}

	public override NodeType node_type { get { return NodeType.FORMAL_PARAMETER; } }

	public override void accept (Visitor visitor) {
		visitor.visit_formal_parameter (this);
	}

	internal override void resolve_type_references (Tree root) {
		if (ellipsis) {
			return;
		}

		parameter_type.resolve_type_references (root);

		base.resolve_type_references (root);
		this.root = root;
	}

	private Tree root;

	private class InitializerBuilder : Vala.CodeVisitor {
		private SignatureBuilder signature;
		private Tree root;

		private void write_node (Vala.Symbol vsymbol) {
			signature.append_symbol (root.search_vala_symbol (vsymbol));
		}

		private void write_type (Vala.DataType vsymbol) {
			if (vsymbol.data_type != null) {
				write_node (vsymbol.data_type);
			} else {
				signature.append_literal ("null");
			}

			var type_args = vsymbol.get_type_arguments ();
			if (type_args.size > 0) {
				signature.append ("<");
				bool first = true;
				foreach (Vala.DataType type_arg in type_args) {
					if (!first) {
						signature.append (",");
					} else {
						first = false;
					}
					if (!type_arg.value_owned) {
						signature.append_keyword ("weak");
					}
					signature.append (type_arg.to_qualified_string (null));
				}
				signature.append (">");
			}

			if (vsymbol.nullable) {
				signature.append ("?");
			}
		}

		public override void visit_array_creation_expression (Vala.ArrayCreationExpression expr) {
			signature.append_keyword ("new");
			write_type (expr.element_type);
			signature.append ("[", false);

			bool first = true;
			foreach (Vala.Expression size in expr.get_sizes ()) {
				if (!first) {
					signature.append (", ", false);
				}
				size.accept (this);
				first = false;
			}

			signature.append ("]", false);

			if (expr.initializer_list != null) {
				signature.append (" ", false);
				expr.initializer_list.accept (this);
			}
		}

		public InitializerBuilder (SignatureBuilder signature, Tree root) {
			this.signature = signature;
			this.root = root;
		}

		public override void visit_binary_expression (Vala.BinaryExpression expr) {
			expr.left.accept (this);

			switch (expr.operator) {
			case Vala.BinaryOperator.PLUS:
				signature.append ("+ ");
				break;

			case Vala.BinaryOperator.MINUS:
				signature.append ("- ");
				break;

			case Vala.BinaryOperator.MUL:
				signature.append ("* ");
				break;

			case Vala.BinaryOperator.DIV:
				signature.append ("/ ");
				break;

			case Vala.BinaryOperator.MOD:
				signature.append ("% ");
				break;

			case Vala.BinaryOperator.SHIFT_LEFT:
				signature.append ("<< ");
				break;

			case Vala.BinaryOperator.SHIFT_RIGHT:
				signature.append (">> ");
				break;

			case Vala.BinaryOperator.LESS_THAN:
				signature.append ("< ");
				break;

			case Vala.BinaryOperator.GREATER_THAN:
				signature.append ("> ");
				break;

			case Vala.BinaryOperator.LESS_THAN_OR_EQUAL:
				signature.append ("<= ");
				break;

			case Vala.BinaryOperator.GREATER_THAN_OR_EQUAL:
				signature.append (">= ");
				break;

			case Vala.BinaryOperator.EQUALITY:
				signature.append ("== ");
				break;

			case Vala.BinaryOperator.INEQUALITY:
				signature.append ("!= ");
				break;

			case Vala.BinaryOperator.BITWISE_AND:
				signature.append ("& ");
				break;

			case Vala.BinaryOperator.BITWISE_OR:
				signature.append ("| ");
				break;

			case Vala.BinaryOperator.BITWISE_XOR:
				signature.append ("^ ");
				break;

			case Vala.BinaryOperator.AND:
				signature.append ("&& ");
				break;

			case Vala.BinaryOperator.OR:
				signature.append ("|| ");
				break;

			case Vala.BinaryOperator.IN:
				signature.append_keyword ("in");
				signature.append (" ");
				break;

			case Vala.BinaryOperator.COALESCE:
				signature.append ("?? ");
				break;

			default:
				assert_not_reached ();
			}

			expr.right.accept (this);
		}

		public override void visit_unary_expression (Vala.UnaryExpression expr) {
			switch (expr.operator) {
			case Vala.UnaryOperator.PLUS:
				signature.append ("+");
				break;

			case Vala.UnaryOperator.MINUS:
				signature.append ("-");
				break;

			case Vala.UnaryOperator.LOGICAL_NEGATION:
				signature.append ("!");
				break;

			case Vala.UnaryOperator.BITWISE_COMPLEMENT:
				signature.append ("~");
				break;

			case Vala.UnaryOperator.INCREMENT:
				signature.append ("++");
				break;

			case Vala.UnaryOperator.DECREMENT:
				signature.append ("--");
				break;

			case Vala.UnaryOperator.REF:
				signature.append_keyword ("ref");
				break;

			case Vala.UnaryOperator.OUT:
				signature.append_keyword ("out");
				break;

			default:
				assert_not_reached ();
			}
			expr.inner.accept (this);
		}

		public override void visit_assignment (Vala.Assignment a) {
			a.left.accept (this);

			switch (a.operator) {
			case Vala.AssignmentOperator.SIMPLE:
				signature.append ("=");
				break;

			case Vala.AssignmentOperator.BITWISE_OR:
				signature.append ("|");
				break;

			case Vala.AssignmentOperator.BITWISE_AND:
				signature.append ("&");
				break;

			case Vala.AssignmentOperator.BITWISE_XOR:
				signature.append ("^");
				break;

			case Vala.AssignmentOperator.ADD:
				signature.append ("+");
				break;

			case Vala.AssignmentOperator.SUB:
				signature.append ("-");
				break;

			case Vala.AssignmentOperator.MUL:
				signature.append ("*");
				break;

			case Vala.AssignmentOperator.DIV:
				signature.append ("/");
				break;

			case Vala.AssignmentOperator.PERCENT:
				signature.append ("%");
				break;

			case Vala.AssignmentOperator.SHIFT_LEFT:
				signature.append ("<<");
				break;

			case Vala.AssignmentOperator.SHIFT_RIGHT:
				signature.append (">>");
				break;

			default:
				assert_not_reached ();
			}

			a.right.accept (this);
		}

		public override void visit_cast_expression (Vala.CastExpression expr) {
			if (expr.is_non_null_cast) {
				signature.append ("(!)");
				expr.inner.accept (this);
				return;
			}

			if (!expr.is_silent_cast) {
				signature.append ("(", false);
				write_type (expr.type_reference);
				signature.append (")", false);
			}

			expr.inner.accept (this);

			if (expr.is_silent_cast) {
				signature.append_keyword ("as");
				write_type (expr.type_reference);
			}
		}

		public override void visit_initializer_list (Vala.InitializerList list) {
			signature.append ("{", false);

			bool first = true;
			foreach (Vala.Expression initializer in list.get_initializers ()) {
				if (!first) {
					signature.append (", ", false);
				}
				first = false;
				initializer.accept (this);
			}

			signature.append ("}", false);
		}

		public override void visit_member_access (Vala.MemberAccess expr) {
			if (expr.symbol_reference != null) {
				expr.symbol_reference.accept (this);
			} else {
				signature.append (expr.member_name);
			}
		}

		public override void visit_element_access (Vala.ElementAccess expr) {
			expr.container.accept (this);
			signature.append ("[", false);

			bool first = true;
			foreach (Vala.Expression index in expr.get_indices ()) {
				if (!first) {
					signature.append (", ", false);
				}
				first = false;

				index.accept (this);
			}

			signature.append ("]", false);
		}

		public override void visit_pointer_indirection (Vala.PointerIndirection expr) {
			signature.append ("*", false);
			expr.inner.accept (this);
		}

		public override void visit_addressof_expression (Vala.AddressofExpression expr) {
			signature.append ("&", false);
			expr.inner.accept (this);
		}

		public override void visit_reference_transfer_expression (Vala.ReferenceTransferExpression expr) {
			signature.append ("(", false).append_keyword ("owned", false).append (")", false);
			expr.inner.accept (this);
		}

		public override void visit_type_check (Vala.TypeCheck expr) {
			expr.expression.accept (this);
			signature.append_keyword ("is");
			write_type (expr.type_reference);
		}

		public override void visit_method_call (Vala.MethodCall expr) {
			// symbol-name:
			expr.call.symbol_reference.accept (this);

			// parameters:
			signature.append (" (", false);
			bool first = true;
			foreach (Vala.Expression literal in expr.get_argument_list ()) {
				if (!first) {
					signature.append (", ", false);
				}

				literal.accept (this);
				first = false;
			}
			signature.append (")", false);
		}

		public override void visit_slice_expression (Vala.SliceExpression expr) {
			expr.container.accept (this);
			signature.append ("[", false);
			expr.start.accept (this);
			signature.append (":", false);
			expr.stop.accept (this);
			signature.append ("]", false);
		}

		public override void visit_base_access (Vala.BaseAccess expr) {
			signature.append_keyword ("base", false);
		}

		public override void visit_postfix_expression (Vala.PostfixExpression expr) {
			expr.inner.accept (this);
			if (expr.increment) {
				signature.append ("++", false);
			} else {
				signature.append ("--", false);
			}
		}

		public override void visit_object_creation_expression (Vala.ObjectCreationExpression expr) {
			if (!expr.struct_creation) {
				signature.append_keyword ("new");
			}

			signature.append_symbol (root.search_vala_symbol (expr.symbol_reference));

			signature.append (" (", false);

			//TODO: rm conditional space
			bool first = true;
			foreach (Vala.Expression arg in expr.get_argument_list ()) {
				if (!first) {
					signature.append (", ", false);
				}
				arg.accept (this);
				first = false;
			}

			signature.append (")", false);
		}

		public override void visit_sizeof_expression (Vala.SizeofExpression expr) {
			signature.append_keyword ("sizeof", false).append (" (", false);
			write_type (expr.type_reference);
			signature.append (")", false);
		}

		public override void visit_typeof_expression (Vala.TypeofExpression expr) {
			signature.append_keyword ("typeof", false).append (" (", false);
			write_type (expr.type_reference);
			signature.append (")", false);
		}

		public override void visit_lambda_expression (Vala.LambdaExpression expr) {
			signature.append ("(", false);

			bool first = true;
			foreach (string param in expr.get_parameters ()) {
				if (!first) {
					signature.append (", ", false);
				}
				signature.append (param, false);
				first = false;
			}

			var run = new Run (Run.Style.ITALIC);
			run.content.add (new Text (" [...] "));

			signature.append (") => {", false);
			signature.append_content (run, false);
			signature.append ("}", false);
		}



		public override void visit_boolean_literal (Vala.BooleanLiteral lit) {
			signature.append_literal (lit.to_string (), false);
		}

		public override void visit_character_literal (Vala.CharacterLiteral lit) {
			signature.append_literal (lit.to_string (), false);
		}

		public override void visit_integer_literal (Vala.IntegerLiteral lit) {
			signature.append_literal (lit.to_string (), false);
		}

		public override void visit_real_literal (Vala.RealLiteral lit) {
			signature.append_literal (lit.to_string (), false);
		}

		public override void visit_regex_literal (Vala.RegexLiteral lit) {
			signature.append_literal (lit.to_string (), false);
		}

		public override void visit_string_literal (Vala.StringLiteral lit) {
			signature.append_literal (lit.to_string (), false);
		}

		public override void visit_list_literal (Vala.ListLiteral lit) {
			signature.append_literal (lit.to_string (), false);
		}

		public override void visit_null_literal (Vala.NullLiteral lit) {
			signature.append_literal (lit.to_string (), false);
		}



		public override void visit_field (Vala.Field field) {
			write_node (field);
		}

		public override void visit_constant (Vala.Constant constant) {
			write_node (constant);
		}

		public override void visit_enum_value (Vala.EnumValue ev) {
			write_node (ev);
		}

		public override void visit_error_code (Vala.ErrorCode ec) {
			write_node (ec);
		}

		public override void visit_delegate (Vala.Delegate d) {
			write_node (d);
		}

		public override void visit_method (Vala.Method m) {
			write_node (m);
		}

		public override void visit_creation_method (Vala.CreationMethod m) {
			write_node (m);
		}

		public override void visit_signal (Vala.Signal sig) {
			write_node (sig);
		}

		public override void visit_class (Vala.Class c) {
			write_node (c);
		}

		public override void visit_struct (Vala.Struct s) {
			write_node (s);
		}

		public override void visit_interface (Vala.Interface i) {
			write_node (i);
		}

		public override void visit_enum (Vala.Enum en) {
			write_node (en);
		}

		public override void visit_error_domain (Vala.ErrorDomain ed) {
			write_node (ed);
		}

		public override void visit_property (Vala.Property prop) {
			write_node (prop);
		}
	}

	protected override Inline build_signature () {
		var signature = new SignatureBuilder ();

		if (ellipsis) {
			signature.append ("...");
		} else {
			if (is_out) {
				signature.append_keyword ("out");
			} else if (is_ref) {
				signature.append_keyword ("ref");
			}

			signature.append_content (parameter_type.signature);
			signature.append (name);

			if (has_default_value) {
				signature.append ("=");

				var inbuilder = new InitializerBuilder (signature, root);
				((Vala.Parameter) symbol).initializer.accept (inbuilder);
			}
		}

		return signature.get ();
	}
}

