/* gstreamer-play-1.0.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "Gst", gir_namespace = "GstPlay", gir_version = "1.0", lower_case_cprefix = "gst_")]
namespace Gst {
	namespace Play {
		[CCode (cheader_filename = "gst/play/play.h", type_id = "gst_play_audio_info_get_type ()")]
		[GIR (name = "PlayAudioInfo")]
		[Version (since = "1.20")]
		public class AudioInfo : Gst.Play.StreamInfo {
			[CCode (has_construct_function = false)]
			protected AudioInfo ();
			public int get_bitrate ();
			public int get_channels ();
			public unowned string get_language ();
			public int get_max_bitrate ();
			public int get_sample_rate ();
		}
		[CCode (cheader_filename = "gst/play/play.h", type_id = "gst_play_media_info_get_type ()")]
		[GIR (name = "PlayMediaInfo")]
		[Version (since = "1.20")]
		public class MediaInfo : GLib.Object {
			[CCode (has_construct_function = false)]
			protected MediaInfo ();
			public unowned GLib.List<Gst.Play.AudioInfo> get_audio_streams ();
			public unowned string get_container_format ();
			public Gst.ClockTime get_duration ();
			public unowned Gst.Sample get_image_sample ();
			public uint get_number_of_audio_streams ();
			public uint get_number_of_streams ();
			public uint get_number_of_subtitle_streams ();
			public uint get_number_of_video_streams ();
			public unowned GLib.List<Gst.Play.StreamInfo> get_stream_list ();
			public unowned GLib.List<Gst.Play.SubtitleInfo> get_subtitle_streams ();
			public unowned Gst.TagList get_tags ();
			public unowned string get_title ();
			public unowned string get_uri ();
			public unowned GLib.List<Gst.Play.VideoInfo> get_video_streams ();
			public bool is_live ();
			public bool is_seekable ();
		}
		[CCode (cheader_filename = "gst/play/play.h", cname = "GstPlay", lower_case_cprefix = "gst_play_", type_id = "gst_play_get_type ()")]
		[GIR (name = "Play")]
		[Version (since = "1.20")]
		public class Play : Gst.Object {
			[CCode (has_construct_function = false)]
			public Play (owned Gst.Play.VideoRenderer? video_renderer);
			public static uint config_get_position_update_interval (Gst.Structure config);
			public static bool config_get_seek_accurate (Gst.Structure config);
			public static string config_get_user_agent (Gst.Structure config);
			public static void config_set_position_update_interval (Gst.Structure config, uint interval);
			public static void config_set_seek_accurate (Gst.Structure config, bool accurate);
			public static void config_set_user_agent (Gst.Structure config, string agent);
			public static unowned GLib.List<Gst.Play.AudioInfo> get_audio_streams (Gst.Play.MediaInfo info);
			public int64 get_audio_video_offset ();
			public double get_color_balance (Gst.Play.ColorBalanceType type);
			public Gst.Structure get_config ();
			public Gst.Play.AudioInfo get_current_audio_track ();
			public Gst.Play.SubtitleInfo get_current_subtitle_track ();
			public Gst.Play.VideoInfo get_current_video_track ();
			public string get_current_visualization ();
			public Gst.ClockTime get_duration ();
			public Gst.Play.MediaInfo get_media_info ();
			public Gst.Bus get_message_bus ();
			public Gst.Video.MultiviewFlags get_multiview_flags ();
			public Gst.Video.MultiviewFramePacking get_multiview_mode ();
			public bool get_mute ();
			public Gst.Element get_pipeline ();
			public Gst.ClockTime get_position ();
			public double get_rate ();
			public static unowned GLib.List<Gst.Play.SubtitleInfo> get_subtitle_streams (Gst.Play.MediaInfo info);
			public string get_subtitle_uri ();
			public int64 get_subtitle_video_offset ();
			public string get_uri ();
			public Gst.Sample get_video_snapshot (Gst.Play.SnapshotFormat format, Gst.Structure? config);
			public static unowned GLib.List<Gst.Play.VideoInfo> get_video_streams (Gst.Play.MediaInfo info);
			public double get_volume ();
			public bool has_color_balance ();
			public static bool is_play_message (Gst.Message msg);
			public void pause ();
			public void play ();
			public void seek (Gst.ClockTime position);
			public bool set_audio_track (int stream_index);
			public void set_audio_track_enabled (bool enabled);
			public void set_audio_video_offset (int64 offset);
			public void set_color_balance (Gst.Play.ColorBalanceType type, double value);
			public bool set_config (owned Gst.Structure config);
			public void set_multiview_flags (Gst.Video.MultiviewFlags flags);
			public void set_multiview_mode (Gst.Video.MultiviewFramePacking mode);
			public void set_mute (bool val);
			public void set_rate (double rate);
			public bool set_subtitle_track (int stream_index);
			public void set_subtitle_track_enabled (bool enabled);
			public void set_subtitle_uri (string uri);
			public void set_subtitle_video_offset (int64 offset);
			public void set_uri (string uri);
			public bool set_video_track (int stream_index);
			public void set_video_track_enabled (bool enabled);
			public bool set_visualization (string name);
			public void set_visualization_enabled (bool enabled);
			public void set_volume (double val);
			public void stop ();
			public static void visualizations_free (Gst.Play.Visualization viss);
			[CCode (array_length = false, array_null_terminated = true)]
			public static Gst.Play.Visualization[] visualizations_get ();
			public int64 audio_video_offset { get; set; }
			public Gst.Play.AudioInfo current_audio_track { owned get; }
			public Gst.Play.SubtitleInfo current_subtitle_track { owned get; }
			public Gst.Play.VideoInfo current_video_track { owned get; }
			public uint64 duration { get; }
			public Gst.Play.MediaInfo media_info { owned get; }
			public bool mute { get; set; }
			public Gst.Element pipeline { owned get; }
			public uint64 position { get; }
			public double rate { get; set; }
			public int64 subtitle_video_offset { get; set; }
			[NoAccessorMethod]
			public string suburi { owned get; set; }
			public string uri { owned get; set; }
			[NoAccessorMethod]
			public Gst.Video.MultiviewFlags video_multiview_flags { get; set; }
			[NoAccessorMethod]
			public Gst.Video.MultiviewFramePacking video_multiview_mode { get; set; }
			[NoAccessorMethod]
			public Gst.Play.VideoRenderer video_renderer { construct; }
			public double volume { get; set; }
		}
		[CCode (cheader_filename = "gst/play/play.h", type_id = "gst_play_signal_adapter_get_type ()")]
		[GIR (name = "PlaySignalAdapter")]
		[Version (since = "1.20")]
		public class SignalAdapter : GLib.Object {
			[CCode (has_construct_function = false)]
			public SignalAdapter (Gst.Play.Play play);
			public unowned Gst.Play.Play get_play ();
			[CCode (has_construct_function = false)]
			public SignalAdapter.sync_emit (Gst.Play.Play play);
			[CCode (has_construct_function = false)]
			public SignalAdapter.with_main_context (Gst.Play.Play play, GLib.MainContext context);
			public Gst.Play.Play play { get; }
			public signal void buffering (int object);
			public signal void duration_changed (uint64 object);
			public signal void end_of_stream ();
			public signal void error (GLib.Error object, Gst.Structure p0);
			public signal void media_info_updated (Gst.Play.MediaInfo object);
			public signal void mute_changed (bool object);
			public signal void position_updated (uint64 object);
			public signal void seek_done (uint64 object);
			public signal void state_changed (Gst.Play.State object);
			public signal void uri_loaded (string object);
			public signal void video_dimensions_changed (uint object, uint p0);
			public signal void volume_changed (double object);
			public signal void warning (GLib.Error object, Gst.Structure p0);
		}
		[CCode (cheader_filename = "gst/play/play.h", type_id = "gst_play_stream_info_get_type ()")]
		[GIR (name = "PlayStreamInfo")]
		[Version (since = "1.20")]
		public abstract class StreamInfo : GLib.Object {
			[CCode (has_construct_function = false)]
			protected StreamInfo ();
			public unowned Gst.Caps get_caps ();
			public unowned string get_codec ();
			public int get_index ();
			public unowned string get_stream_type ();
			public unowned Gst.TagList get_tags ();
		}
		[CCode (cheader_filename = "gst/play/play.h", type_id = "gst_play_subtitle_info_get_type ()")]
		[GIR (name = "PlaySubtitleInfo")]
		[Version (since = "1.20")]
		public class SubtitleInfo : Gst.Play.StreamInfo {
			[CCode (has_construct_function = false)]
			protected SubtitleInfo ();
			public unowned string get_language ();
		}
		[CCode (cheader_filename = "gst/play/play.h", type_id = "gst_play_video_info_get_type ()")]
		[GIR (name = "PlayVideoInfo")]
		[Version (since = "1.20")]
		public class VideoInfo : Gst.Play.StreamInfo {
			[CCode (has_construct_function = false)]
			protected VideoInfo ();
			public int get_bitrate ();
			public void get_framerate (out int fps_n, out int fps_d);
			public int get_height ();
			public int get_max_bitrate ();
			public void get_pixel_aspect_ratio (out uint par_n, out uint par_d);
			public int get_width ();
		}
		[CCode (cheader_filename = "gst/play/play.h", type_id = "gst_play_video_overlay_video_renderer_get_type ()")]
		[GIR (name = "PlayVideoOverlayVideoRenderer")]
		[Version (since = "1.20")]
		public class VideoOverlayVideoRenderer : GLib.Object, Gst.Play.VideoRenderer {
			[CCode (has_construct_function = false, type = "GstPlayVideoRenderer*")]
			public VideoOverlayVideoRenderer (void* window_handle);
			public void expose ();
			public void get_render_rectangle (out int x, out int y, out int width, out int height);
			public void* get_window_handle ();
			public void set_render_rectangle (int x, int y, int width, int height);
			public void set_window_handle (void* window_handle);
			[CCode (has_construct_function = false, type = "GstPlayVideoRenderer*")]
			public VideoOverlayVideoRenderer.with_sink (void* window_handle, Gst.Element video_sink);
			[NoAccessorMethod]
			public Gst.Element video_sink { owned get; set; }
			public void* window_handle { get; set construct; }
		}
		[CCode (cheader_filename = "gst/play/play.h", copy_function = "g_boxed_copy", free_function = "g_boxed_free", type_id = "gst_play_visualization_get_type ()")]
		[Compact]
		[GIR (name = "PlayVisualization")]
		[Version (since = "1.20")]
		public class Visualization {
			public weak string description;
			public weak string name;
			public Gst.Play.Visualization copy ();
			public void free ();
		}
		[CCode (cheader_filename = "gst/play/play.h", type_cname = "GstPlayVideoRendererInterface", type_id = "gst_play_video_renderer_get_type ()")]
		[GIR (name = "PlayVideoRenderer")]
		[Version (since = "1.20")]
		public interface VideoRenderer : GLib.Object {
		}
		[CCode (cheader_filename = "gst/play/play.h", cprefix = "GST_PLAY_COLOR_BALANCE_", type_id = "gst_play_color_balance_type_get_type ()")]
		[GIR (name = "PlayColorBalanceType")]
		[Version (since = "1.20")]
		public enum ColorBalanceType {
			HUE,
			BRIGHTNESS,
			SATURATION,
			CONTRAST
		}
		[CCode (cheader_filename = "gst/play/play.h", cprefix = "GST_PLAY_MESSAGE_", type_id = "gst_play_message_get_type ()")]
		[GIR (name = "PlayMessage")]
		[Version (since = "1.20")]
		public enum Message {
			URI_LOADED,
			POSITION_UPDATED,
			DURATION_CHANGED,
			STATE_CHANGED,
			BUFFERING,
			END_OF_STREAM,
			ERROR,
			WARNING,
			VIDEO_DIMENSIONS_CHANGED,
			MEDIA_INFO_UPDATED,
			VOLUME_CHANGED,
			MUTE_CHANGED,
			SEEK_DONE
		}
		[CCode (cheader_filename = "gst/play/play.h", cprefix = "GST_PLAY_THUMBNAIL_", has_type_id = false)]
		[GIR (name = "PlaySnapshotFormat")]
		[Version (since = "1.20")]
		public enum SnapshotFormat {
			RAW_NATIVE,
			[CCode (cname = "GST_PLAY_THUMBNAIL_RAW_xRGB")]
			RAW_XRGB,
			[CCode (cname = "GST_PLAY_THUMBNAIL_RAW_BGRx")]
			RAW_BGRX,
			JPG,
			PNG
		}
		[CCode (cheader_filename = "gst/play/play.h", cprefix = "GST_PLAY_STATE_", type_id = "gst_play_state_get_type ()")]
		[GIR (name = "PlayState")]
		[Version (since = "1.20")]
		public enum State {
			STOPPED,
			BUFFERING,
			PAUSED,
			PLAYING
		}
		[CCode (cheader_filename = "gst/play/play.h", cprefix = "GST_PLAY_ERROR_")]
		[GIR (name = "PlayError")]
		[Version (since = "1.20")]
		public errordomain Error {
			FAILED
		}
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_color_balance_type_get_name")]
		[Version (since = "1.20")]
		public static unowned string play_color_balance_type_get_name (Gst.Play.ColorBalanceType type);
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_error_get_name")]
		[Version (since = "1.20")]
		public static unowned string play_error_get_name (Gst.Play.Error error);
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_error_quark")]
		[Version (since = "1.20")]
		public static GLib.Quark play_error_quark ();
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_message_get_name")]
		[Version (since = "1.20")]
		public static unowned string play_message_get_name (Gst.Play.Message message_type);
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_message_parse_buffering_percent")]
		[Version (since = "1.20")]
		public static void play_message_parse_buffering_percent (Gst.Message msg, out uint percent);
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_message_parse_duration_updated")]
		[Version (since = "1.20")]
		public static void play_message_parse_duration_updated (Gst.Message msg, out Gst.ClockTime duration);
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_message_parse_error")]
		[Version (since = "1.20")]
		public static void play_message_parse_error (Gst.Message msg, out unowned GLib.Error error, out Gst.Structure details);
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_message_parse_media_info_updated")]
		[Version (since = "1.20")]
		public static void play_message_parse_media_info_updated (Gst.Message msg, out Gst.Play.MediaInfo info);
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_message_parse_muted_changed")]
		[Version (since = "1.20")]
		public static void play_message_parse_muted_changed (Gst.Message msg, out bool muted);
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_message_parse_position_updated")]
		[Version (since = "1.20")]
		public static void play_message_parse_position_updated (Gst.Message msg, out Gst.ClockTime position);
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_message_parse_state_changed")]
		[Version (since = "1.20")]
		public static void play_message_parse_state_changed (Gst.Message msg, out Gst.Play.State state);
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_message_parse_type")]
		[Version (since = "1.20")]
		public static void play_message_parse_type (Gst.Message msg, out Gst.Play.Message type);
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_message_parse_video_dimensions_changed")]
		[Version (since = "1.20")]
		public static void play_message_parse_video_dimensions_changed (Gst.Message msg, out uint width, out uint height);
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_message_parse_volume_changed")]
		[Version (since = "1.20")]
		public static void play_message_parse_volume_changed (Gst.Message msg, out double volume);
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_message_parse_warning")]
		[Version (since = "1.20")]
		public static void play_message_parse_warning (Gst.Message msg, out unowned GLib.Error error, out Gst.Structure details);
		[CCode (cheader_filename = "gst/play/play.h", cname = "gst_play_state_get_name")]
		[Version (since = "1.20")]
		public static unowned string play_state_get_name (Gst.Play.State state);
	}
}
