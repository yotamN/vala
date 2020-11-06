/* gstreamer-app-1.0.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "Gst", gir_namespace = "GstApp", gir_version = "1.0", lower_case_cprefix = "gst_")]
namespace Gst {
	namespace App {
		[CCode (cheader_filename = "gst/app/app.h", type_id = "gst_app_sink_get_type ()")]
		[GIR (name = "AppSink")]
		public class Sink : Gst.Base.Sink, Gst.URIHandler {
			[CCode (has_construct_function = false)]
			protected Sink ();
			[Version (since = "1.12")]
			public bool get_buffer_list_support ();
			public Gst.Caps get_caps ();
			public bool get_drop ();
			public bool get_emit_signals ();
			public uint get_max_buffers ();
			public bool get_wait_on_eos ();
			public bool is_eos ();
			[Version (since = "1.12")]
			public void set_buffer_list_support (bool enable_lists);
			public void set_caps (Gst.Caps? caps);
			public void set_drop (bool drop);
			public void set_emit_signals (bool emit);
			public void set_max_buffers (uint max);
			public void set_wait_on_eos (bool wait);
			[NoAccessorMethod]
			public bool buffer_list { get; set; }
			public Gst.Caps caps { owned get; set; }
			public bool drop { get; set; }
			public bool emit_signals { get; set; }
			[NoAccessorMethod]
			public virtual bool eos { get; }
			public uint max_buffers { get; set; }
			public bool wait_on_eos { get; set; }
			public virtual signal Gst.FlowReturn new_preroll ();
			public virtual signal Gst.FlowReturn new_sample ();
			[HasEmitter]
			public virtual signal Gst.Sample pull_preroll ();
			[HasEmitter]
			public virtual signal Gst.Sample pull_sample ();
			[HasEmitter]
			[Version (since = "1.10")]
			public virtual signal Gst.Sample try_pull_preroll (uint64 timeout);
			[HasEmitter]
			[Version (since = "1.10")]
			public virtual signal Gst.Sample try_pull_sample (uint64 timeout);
		}
		[CCode (cheader_filename = "gst/app/app.h", type_id = "gst_app_src_get_type ()")]
		[GIR (name = "AppSrc")]
		public class Src : Gst.Base.Src, Gst.URIHandler {
			[CCode (has_construct_function = false)]
			protected Src ();
			public Gst.Caps get_caps ();
			[Version (since = "1.2")]
			public uint64 get_current_level_bytes ();
			[Version (since = "1.10")]
			public Gst.ClockTime get_duration ();
			public bool get_emit_signals ();
			public void get_latency (out uint64 min, out uint64 max);
			public uint64 get_max_bytes ();
			public int64 get_size ();
			public Gst.App.StreamType get_stream_type ();
			public virtual Gst.FlowReturn push_buffer (owned Gst.Buffer buffer);
			[Version (since = "1.14")]
			public virtual Gst.FlowReturn push_buffer_list (owned Gst.BufferList buffer_list);
			public void set_caps (Gst.Caps? caps);
			[Version (since = "1.10")]
			public void set_duration (Gst.ClockTime duration);
			public void set_emit_signals (bool emit);
			public void set_latency (uint64 min, uint64 max);
			public void set_max_bytes (uint64 max);
			public void set_size (int64 size);
			public void set_stream_type (Gst.App.StreamType type);
			[NoAccessorMethod]
			public bool block { get; set; }
			public Gst.Caps caps { owned get; set; }
			[Version (since = "1.2")]
			public uint64 current_level_bytes { get; }
			[Version (since = "1.10")]
			public uint64 duration { get; set; }
			public bool emit_signals { get; set; }
			[NoAccessorMethod]
			public Gst.Format format { get; set; }
			[NoAccessorMethod]
			[Version (since = "1.18")]
			public bool handle_segment_change { get; set; }
			[NoAccessorMethod]
			public bool is_live { get; set; }
			public uint64 max_bytes { get; set; }
			[NoAccessorMethod]
			public int64 max_latency { get; set; }
			[NoAccessorMethod]
			public int64 min_latency { get; set; }
			[NoAccessorMethod]
			public uint min_percent { get; set; }
			public int64 size { get; set; }
			public Gst.App.StreamType stream_type { get; set; }
			[HasEmitter]
			public virtual signal Gst.FlowReturn end_of_stream ();
			public virtual signal void enough_data ();
			public virtual signal void need_data (uint length);
			[CCode (cname = "push-buffer")]
			public signal Gst.FlowReturn on_push_buffer (Gst.Buffer object);
			[CCode (cname = "push-buffer-list")]
			public signal Gst.FlowReturn on_push_buffer_list (Gst.BufferList object);
			[HasEmitter]
			public virtual signal Gst.FlowReturn push_sample (Gst.Sample sample);
			public virtual signal bool seek_data (uint64 offset);
		}
		[CCode (cheader_filename = "gst/app/app.h", cprefix = "GST_APP_STREAM_TYPE_", type_id = "gst_app_stream_type_get_type ()")]
		[GIR (name = "AppStreamType")]
		public enum StreamType {
			STREAM,
			SEEKABLE,
			RANDOM_ACCESS
		}
	}
}
