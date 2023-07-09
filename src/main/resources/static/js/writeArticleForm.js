/**
 * 
 */
function writeAction () {
	if ($('#art_title').val() == '' || $('#art_title').val() == null) {
		return false;
	}
	if ($('#art_content').val() == '' || $('#art_content').val() == null) {
		return false;
	}
	let tagIndex = 1;
	$('.tag-box-tag').each((index, value) => {
		let tag = $(value).find('.tag-box-tag-value').html();
		$('#art_tag' + tagIndex++).val(tag);
	});
	return true;
}
const quillInit = (id) => {
	let fontArray = [];
	for (let i = 8; i <= 30; i++) fontArray[fontArray.length] = i + 'px';
	var Size = Quill.import('attributors/style/size');
	Size.whitelist = fontArray;
	Quill.register(Size, true);
	var option = {
		modules: {
			toolbar: [
					[{size: fontArray}],
					[{'color': [
						'#FFFFFF', '#FF0000', '#FFFF00', '#00FF00', '#00FFFF', '#0000FF', '#FF00FF',
						'#E0E0E0', '#E00000', '#E0E000', '#00E000', '#00E0E0', '#0000E0', '#E000E0',
						'#C0C0C0', '#C00000', '#C0C000', '#00C000', '#00C0C0', '#0000C0', '#C000C0',
						'#A0A0A0', '#A00000', '#A0A000', '#00A000', '#00A0A0', '#0000A0', '#A000A0',
						'#808080', '#800000', '#808000', '#008000', '#008080', '#000080', '#800080',
						'#606060', '#600000', '#606000', '#006000', '#006060', '#000060', '#600060',
						'#404040', '#400000', '#404000', '#004000', '#004040', '#000040', '#400040',
						'#202020', '#200000', '#202000', '#002000', '#002020', '#000020', '#200020',
						'#000000', '#000000', '#000000', '#000000', '#000000', '#000000', '#000000'
					]}],
					['bold', 'italic', 'underline', 'strike'],
					['image', 'video', 'link'],
					[{list: 'ordered'}, {list: 'bullet'}]
			],
			imageResize: {
				displaySize: true
			},
			imageDrop: true
		},
		placeholder: '내용을 입력해주세요',
		theme: 'snow'
	};
	editor = new Quill('#' + id, option);
};
var editor;
$(() => {
	// Load Editor
	quillInit('articleEditor');
	
	// input keydown event
	$('form input').keydown(e => {
		if (e.keyCode == 13) e.preventDefault();
	});
	
	// Tag input Effects
	$('#tag-input').keydown(e => {
		if ($('#tag-box').find('.tag-box-tag').length >= 5 && e.keyCode != 8) {
			e.preventDefault();
			e.target.value = null;
			return;
		}
		if (e.keyCode == 32) {
			e.preventDefault();
			if (e.target.value == '' || !e.target.value || e.target.value == null) return;
			$(e.target).blur();
			e.target.value = null;
			$(e.target).focus();
		} else if (e.keyCode == 13) e.preventDefault();
		else if (e.keyCode == 8) {
			if (e.target.selectionStart == 0 && e.target.selectionEnd == 0) {
				$('#tag-box').find('div.tag-box-tag:last-child').remove();
				e.preventDefault();
			}
		}
	});
	$('#tag-input').blur(e => {
		if ($('#tag-box').find('.tag-box-tag').length >= 5) {
			e.target.value = null;
			return;
		}
		if (e.target.value == '' || !e.target.value || e.target.value == null) return;
		let elem = '<div class="tag-box-tag"><span class="tag-box-tag-value">' + e.target.value + '</span><button class="tag-box-tag-remove adv-hover" type="button"><svg class="tag-box-tag-remove-svg" width="10" height="10" viewBox="0 0 12 12" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"><path d="M 2 2 L 10 10 M 10 2 L 2 10"/></svg></button></div>';
		$('#tag-box').append(elem);
		$('#tag-box').find('div.tag-box-tag:last-child > button.tag-box-tag-remove').click(e => {
			$(e.target).parent().remove();
		});
		e.target.value = null;
	});
	editor.on('text-change', () => {
		$('#art_content').val(editor.root.innerHTML);
	});
	const selectLocalImage = () => {
		const fileInput = document.createElement('input');
		fileInput.setAttribute('type', 'file');
		fileInput.click();
		fileInput.addEventListener('change', e => {
			const formData = new FormData();
			const file = fileInput.files[0];
			formData.append('uploadFile', file);
			
			$.ajax({
				type: 'post',
				enctype: 'multipart/form-data',
				url: '/board/${boardName}/imageUpload',
				data: formData,
				processData: false,
				contentType: false,
				dataType: 'json',
				success: function(data) {
					const range = editor.getSelection();
					data.url = data.url.toString().replace(/\\/g, '/');
					editor.insertEmbed(range.index, 'image', data.url);
				}
			});
		});
	};
	editor.getModule('toolbar').addHandler('image', () => selectLocalImage());
});